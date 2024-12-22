require 'capybara'
require 'selenium-webdriver'

require_relative 'drivers/file_detector'

Capybara.default_driver = (ENV['DRIVER'] || 'firefox').to_sym

case Capybara.default_driver
when :chrome
  Capybara.register_driver :chrome do |app|
    driver = Capybara::Selenium::Driver.new(app,
      browser: :chrome
    )
  end
when :firefox
  Capybara.register_driver :firefox do |app|
    driver = Capybara::Selenium::Driver.new(app,
      browser: :firefox
    )
  end
when :headless_chrome
  Capybara.register_driver :headless_chrome do |app|
    options = Selenium::WebDriver::Chrome::Options.new
    options.add_argument('headless')
    options.add_argument('disable-gpu')
    options.add_argument('no-sandbox')
    Capybara::Selenium::Driver.new(
      app,
      browser: :chrome,
      options: options
    )
  end
when :headless_firefox
  Capybara.register_driver :headless_firefox do |app|
    options = Selenium::WebDriver::Firefox::Options.new
    options.args << '--headless'

    Capybara::Selenium::Driver.new(
      app,
      browser: :firefox,
      options: options
    )
  end
end
