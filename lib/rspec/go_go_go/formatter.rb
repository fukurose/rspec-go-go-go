# frozen_string_literal: true

require "rspec/go_go_go/progress_counter"
require "rspec/go_go_go/progress_framer"

require "rspec/core"
require "rspec/core/formatters/base_text_formatter"

module RSpec
  module GoGoGo
    class Formatter < RSpec::Core::Formatters::BaseTextFormatter
      RSpec::Core::Formatters.register self, :start, :example_passed, :example_failed

      def start(notification)
        super
        @counter = ProgressCounter.new(notification.count,
                                       display_line_for_description: ENV.fetch("DISPLAY_LINE_FOR_DESCRIPTION", 10).to_i)
        @output << ProgressFramer.init_display(@counter)
      end

      def example_passed(notification)
        @counter.passed
        @counter.update_recently_descriptions(notification.example.description, :success)
        @output << ProgressFramer.display(@counter)
      end

      def example_failed(notification)
        @counter.failed
        @counter.update_recently_descriptions(notification.example.description, :failure)
        @output << ProgressFramer.display(@counter)
      end
    end
  end
end
