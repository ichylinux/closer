require 'builder'
require 'pathname'
require_relative 'closer_html'

module Closer
  module Formatter
    class HtmlBuilder < Builder::XmlMarkup

      def declare!
        super(:DOCTYPE, :html)
      end

      def build_document!
        declare! # <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

        self << '<html>'

        set_head_tags
      end

      def format_features!(features)
        step_count = features && features.step_count || 0

        self << '<body>'
        self << "<!-- Step count #{step_count}-->"
        self << '<div class="cucumber">'

        div(id: 'cucumber-header') do
          div(id: 'label') do
            h1 'Cucumber Features'
          end

          summary_div
        end
      end

      private

      def summary_div
        div(id: 'summary') do
          p('', id: 'totals')
          p('', id: 'duration')

          expand_collapse
        end
      end

      def expand_collapse
        div(id: 'expand-collapse') do
          p('Expand All', id: 'expander')
          p('Collapse All', id: 'collapser')
        end
      end

      def inline_css
        style do
          pn = ::Pathname.new(::File.dirname(__FILE__) + '/cucumber.css')
          self << pn.read
          pn = ::Pathname.new(::File.dirname(__FILE__) + '/closer.css')
          self << pn.read
        end
      end

      def inline_js
        script do
          self << inline_jquery
          self << inline_closer
          self << inline_js_content
  
          if should_expand
            self << %w{
              $(document).ready(function() {
                $('#expander').click();
              });
            }.join(' ')
          end
        end
      end

      def inline_jquery
        pn = ::Pathname.new(::File.dirname(__FILE__) + '/jquery-min.js')
        pn.read
      end

      def inline_closer
        ret = ''
        pn = ::Pathname.new(::File.dirname(__FILE__) + '/closer.js')
        ret << pn.read
        pn = ::Pathname.new(::File.dirname(__FILE__) + '/screenshot.js')
        ret << pn.read
        ret
      end

      def inline_js_content # rubocop:disable
        <<-EOF
  SCENARIOS = "h3[id^='scenario_'],h3[id^=background_]";

  $(document).ready(function() {
    $(SCENARIOS).delegate('.val', 'click', function() {
      $(this).parent().siblings().toggle(100);
    });

    $("#collapser").css('cursor', 'pointer');
    $("#collapser").click(function() {
      $(SCENARIOS).siblings().addClass('hidden');
      $('li.message').addClass('hidden');
    });

    $("#expander").css('cursor', 'pointer');
    $("#expander").click(function() {
      $(SCENARIOS).siblings().removeClass('hidden');
      $('li.message').removeClass('hidden');
    });
  })

  function moveProgressBar(percentDone) {
    $("cucumber-header").css('width', percentDone +"%");
  }
  function makeRed(element_id) {
    $('#'+element_id).css('background', '#C40D0D');
    $('#'+element_id).css('color', '#FFFFFF');
  }
  function makeYellow(element_id) {
    $('#'+element_id).css('background', '#FAF834');
    $('#'+element_id).css('color', '#000000');
  }
        EOF
      end

      def set_head_tags
        head do
          meta('http-equiv' => 'Content-Type', :content => 'text/html;charset=utf-8')
          title 'Cucumber'
          inline_css
          inline_js
        end
      end

      def should_expand
        ['t', 'true'].include?(::ENV['EXPAND'].to_s.downcase)
      end
    end
  end
end
