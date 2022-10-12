# frozen_string_literal: true

module RSpec
  module GoGoGo
    module ProgressFramer
      module_function

      def cal_width(counter)
        @cal_width ||= begin
          width = terminal_width # terminal width
          width -= result(counter).length
          width -= rate(counter).length
          width -= 5 # blank * 3 and "|" * 2
          width
        end
      end

      def terminal_width
        `tput cols`.to_i
      end

      def display(counter)
        "\r #{result(counter)} #{bar(counter)} #{rate(counter)}"
      end

      def bar(counter)
        width = cal_width(counter)
        progress_bar = if counter.rate >= 1
                         completed_progress_bar(width)
                       elsif counter.rate <= 0
                         no_progress_bar(width)
                       else
                         in_progress_bar(counter, width)
                       end
        "|#{progress_bar}|"
      end

      def result(counter)
        max = counter.total.to_s.length
        format("%#{max}s examples, %#{max}s failures", counter.checks, counter.failures)
      end

      def rate(counter)
        percent = (counter.rate * 100.0).to_int
        "#{format("%3s", percent)}%"
      end

      # bar: ----------
      def no_progress_bar(width)
        "-" * width
      end

      # bar: ====>-----
      def in_progress_bar(counter, width)
        bar_len = counter.rate * width.to_f
        "#{"=" * (bar_len - 1)}>".ljust(width, "-")
      end

      # bar: ==========
      def completed_progress_bar(width)
        "=" * width
      end
    end
  end
end
