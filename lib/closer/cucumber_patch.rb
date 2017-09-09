require 'cucumber'
require 'cucumber/core/ast/step'
require 'cucumber/formatter/console'

module Cucumber
  module Core
    module Ast
      class Step

        def backtrace_line
          "#{location.to_s.force_encoding('UTF-8')}:in `#{keyword.force_encoding('UTF-8')}#{name.force_encoding('UTF-8')}'"
        end

      end
    end
  end
end

module Cucumber
  module Formatter
    module Console

      def print_failing_scenarios(failures, custom_profiles, given_source)
        @io.puts format_string("Failing Scenarios:", :failed)
        failures.each do |failure|
          profiles_string = custom_profiles.empty? ? '' : (custom_profiles.map{|profile| "-p #{profile}" }).join(' ') + ' '
          source = given_source ? format_string(" # " + failure.name, :comment) : ''
          @io.puts format_string("cucumber #{profiles_string}" + failure.location.to_s.force_encoding('UTF-8'), :failed) + source
        end
        @io.puts
      end

    end
  end
end
