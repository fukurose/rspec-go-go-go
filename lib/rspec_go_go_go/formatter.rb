# frozen_string_literal: true

require "rspec/core/formatters/base_text_formatter"

module RSpecGoGoGo
  class Formater < RSpec::Core::Formatters::BaseTextFormatter
    RSpec::Core::Formatters.register self, :start, :example_passed, :example_failed

    def start(notification)
      super
      @counter = ProgressCounter.new(notification.count)
    end

    def example_passed(_notification)
      @counter.passed
      @output << ProgressFramer.display(@counter)
    end

    def example_failed(_notification)
      @counter.failed
      @output << ProgressFramer.display(@counter)
    end
  end
end
