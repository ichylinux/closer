require 'cucumber'
require 'cucumber/core/ast/step'

module Cucumber
  module Core
    module Ast
      class Step

        def backtrace_line
          "#{location.force_encoding('UTF-8')}:in `#{keyword.force_encoding('UTF-8')}#{name.force_encoding('UTF-8')}'"
        end

      end
    end
  end
end
