require 'cucumber/formatter/html'

module Closer
  module Formatter
    class HTML < ::Cucumber::Formatter::HTML

      def output_envelope(envelope)
        @html_formatter.write_message(envelope)
        @html_formatter.write_post_message if envelope.test_run_finished
      end

    end
  end
end
