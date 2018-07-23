require 'cucumber/core/compiler'

module Cucumber
  module Core
    class Compiler
      class TestCaseBuilder

        def on_test_case(source)
          valid_test_case = false
          resume_story_from = ENV['RESUME_STORY_FROM'].to_s

          if resume_story_from.empty?
            valid_test_case = true
          else
            @feature, scenario = *source
            if @feature.location.file >= resume_story_from
              valid_test_case = true
            end
          end

          if valid_test_case
            Test::Case.new(test_steps, source).describe_to(receiver) #if test_steps.count > 0
          end
          @test_steps = nil
          self
        end

      end
    end
  end
end
