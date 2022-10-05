# frozen_string_literal: true

require_relative "rspec_go_go_go/version"

require 'rspec/core/formatters/base_text_formatter'

module RspecGoGoGo

  class Error < StandardError; end
  # Your code goes here...

  class Format < RSpec::Core::Formatters::BaseTextFormatter
    class Progress
      BAR_WIDTH = 80
  
  	  def initialize(total)
        @total = total
  	    @pass = 0
  	    @failure = 0
      end
  
      def passed
        @pass += 1
        bar
      end
  
      def failed
        @failure += 1
        bar
      end
  
      private
  
      def count
        @pass + @failure
      end
  
      def curent
        (@pass + @failure).to_f / @total
      end
  
      def bar
        percent = curent * 100.0
        bar_len = curent * BAR_WIDTH.to_f
        bar_str = "|" + ('=' * bar_len).ljust(BAR_WIDTH) + "|"
        progress_num = '%3.1f' % percent
        "\r #{(@pass + @failure)} examples, #{@failure} failure #{bar_str} #{'%5s' % progress_num}%"
      end
    end
  
  	RSpec::Core::Formatters.register self, :start, :example_passed, :example_failed
        
  	def initialize(output)
      super
  	end
  
    def start(notification)
      super
      @progress = Progress.new(notification.count)
    end
  
  	def example_passed(notification)
      @output << @progress.passed
  	end
        
  	def example_failed(notification)
      @output << @progress.failed
  	end
  end
end
