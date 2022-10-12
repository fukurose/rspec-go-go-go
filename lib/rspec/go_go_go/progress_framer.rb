# frozen_string_literal: true

module RSpec
  module GoGoGo
    module ProgressFramer
      module_function

      def width
        60
      end

      def display(counter)
        "\r #{result(counter)} #{bar(counter)} #{rate(counter)}"
      end

      def bar(counter)
        progress_bar = if counter.rate >= 1
                         completed_progress_bar
                       elsif counter.rate <= 0
                         no_progress_bar
                       else
                         in_progress_bar(counter)
                       end
        "|#{progress_bar}|"
      end

      def result(counter)
        "#{counter.checks} examples, #{counter.failures} failures"
      end

      def rate(counter)
        percent = (counter.rate * 100.0).to_int
        "#{format("%3s", percent)}%"
      end

      # bar: ----------
      def no_progress_bar
        "-" * width
      end

      # bar: ====>-----
      def in_progress_bar(counter)
        bar_len = counter.rate * width.to_f
        "#{"=" * (bar_len - 1)}>".ljust(width, "-")
      end

      # bar: ==========
      def completed_progress_bar
        "=" * width
      end
    end
  end
end
