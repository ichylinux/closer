module Closer
  module Drivers
    class Chrome
      
      def self.options(headless: false)
        options = Selenium::WebDriver::Chrome::Options.new

        options.add_argument('disable-dev-shm-usage')
        options.add_argument('disable-gpu')
        options.add_argument('headless=new') if headless
        options.add_argument('no-sandbox')
        options.add_argument('window-size=1280,720')

        options.add_preference('autofill.profile_enabled', false)

        options
      end
      
    end
  end
end
