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
        options = normalize_options(options)

        unless options.fetch(:force, false)
          return if ENV['FORMAT'] == 'junit'
          return if ENV['CI'] == 'travis'
        end

        url = Rack::Utils.unescape(current_url)
    
        @@_screen_count += 1

        image = File.join(IMAGE_DIR, "#{@@_screen_count}.png")
        page.driver.save_screenshot(image, full: true)

        attrs = {
          class: 'screenshot',
          src: "#{File.basename(IMAGE_DIR)}/#{File.basename(image)}",
          alt: url
        }
        attrs[:title] = options[:title] if options[:title]

        image_tag = "<img #{attrs.map{|k, v| "#{k}=\"#{v}\"" }.join(' ')} />"

        if options[:flash]
          log(image_tag)
        else
          @@_images << image_tag
        end
      end

      def with_capture(options = {})
        options = normalize_options(options)
        begin
          yield
        rescue Exception => e
          options = options.merge(:force => true) unless options.has_key?(:force)
          raise e
        ensure
          capture(options)
        end
      end

      def resize_window(width, height)
        page.driver.browser.manage.window.resize_to(width, height)
      end

      def flash_image_tags
        if @@_images.size > 0
          log(@@_images.join("\n"))
          @@_images.clear
        end
      end

      def normalize_options(options)
        options ||= {}
        options = {:title => options} if options.is_a?(String)
        options
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
