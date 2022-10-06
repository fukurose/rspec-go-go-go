# frozen_string_literal: true

module RSpecGoGoGo
  class ProgressCounter
    def initialize(total)
      @total = total
      @passes = 0
      @failures = 0
    end
    attr_reader :total, :passes, :failures

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
  end
end
