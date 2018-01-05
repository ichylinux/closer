require 'cucumber/core/compiler'

module Cucumber
  module Core
    class Compiler
      class TestCaseBuilder

        def on_test_case(source)
          Test::Case.new(test_steps, source).describe_to(receiver) #if test_steps.count > 0
          @test_steps = nil
          self
        end

      end
    end
  end
end
