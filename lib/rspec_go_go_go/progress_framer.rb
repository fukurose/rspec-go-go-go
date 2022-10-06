# frozen_string_literal: true

module RSpecGoGoGo
  module ProgressFramer
    def display(counter)
      "\r #{result(counter)} #{bar(counter)} #{rate(counter)}"
    end
    module_function :display

    def bar(counter)
      bar_len = counter.rate * 60.to_f
      "|#{("=" * bar_len).ljust(60)}|"
    end
    module_function :bar

    def result(counter)
      "#{counter.checks} examples, #{counter.failures} failures"
    end
    module_function :result

    def rate(counter)
      percent = (counter.rate * 100.0).to_int
      "#{format("%3s", percent)}%"
    end
    module_function :rate
  end
end
