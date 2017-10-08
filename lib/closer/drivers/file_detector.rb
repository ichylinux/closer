module Closer
  module Drivers
    class FileDetector
      
      def self.apply(driver)
        driver.browser.file_detector = lambda do |args|
          str = args.first.to_s
          str if File.exist?(str)
        end
      
        driver
      end

    end
  end
end