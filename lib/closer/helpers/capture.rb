module Closer
  module Helpers
    module Capture
      feature_dir = 'features'
      ARGV.each_with_index do |arg, i|
        if %w{ -r --require }.include?(arg)
          feature_dir = ARGV[i + 1]
          break
        end
      end
      IMAGE_DIR = File.join(feature_dir, 'reports', 'images')
      FileUtils.mkdir_p(IMAGE_DIR)

      @@_screen_count = 0
      @@_images = []
    
      def capture(options = {})
        options ||= {}
        options = {:title => options} if options.is_a?(String)
        return if ENV['FORMAT'] == 'junit'

        url = Rack::Utils.unescape(current_url)
    
        @@_screen_count += 1

        image = File.join(IMAGE_DIR, "#{@@_screen_count}.png")
        page.driver.save_screenshot(image, :full => true)

        attrs = {
          :class => 'screenshot',
          :src => "#{File.basename(IMAGE_DIR)}/#{File.basename(image)}",
          :title => options[:title],
          :alt => url
        }
        image_tag = "<img #{attrs.map{|k, v| "#{k}=\"#{v}\"" }.join(' ')} />"

        if options[:flash]
          puts image_tag
        else
          @@_images << image_tag
        end
      end

      def with_capture(options = {})
        begin
          yield
        ensure
          capture(options)
        end
      end

      def resize_window(width, height)
        case Capybara.current_driver
        when :poltergeist
          Capybara.current_session.driver.resize(width, height)
        when :selenium
          Capybara.current_session.driver.browser.manage.window.resize_to(width, height)
        when :webkit
          # TODO
        end
      end

      def flash_image_tags
        if @@_images.size > 0
          puts @@_images.join("\n")
          @@_images.clear
        end
      end

    end
  end
end

World(Closer::Helpers::Capture)

AfterStep do |step|
  flash_image_tags
end

After do |scenario|
  flash_image_tags
end
