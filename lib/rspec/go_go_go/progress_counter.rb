# frozen_string_literal: true

module RSpec
  module GoGoGo
    class ProgressCounter
      def initialize(total, display_line_for_description: 10)
        @total = total
        @passes = 0
        @failures = 0
        @display_line_for_description = display_line_for_description
        @recently_descriptions = Array.new(display_line_for_description, ["", :success])
      end
      attr_reader :total, :passes, :failures, :recently_descriptions, :display_line_for_description

      def passed
        @passes += 1
      end

      def failed
        @failures += 1
      end

      def checks
        @passes + @failures
      end

      def rate
        (checks.to_f / total).round(2)
      end

      def update_recently_descriptions(description, color)
        @recently_descriptions.shift
        @recently_descriptions.push([description, color])
      end
    end
  end
end
