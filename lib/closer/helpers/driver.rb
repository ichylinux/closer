require 'capybara'
require 'selenium-webdriver'

Dir::glob(File.join(File.dirname(__FILE__), 'drivers', '*.rb')).each do |file|
  require_relative "drivers/#{File.basename(file)}"
end

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
    Capybara::Selenium::Driver.new(
      app,
      browser: :chrome,
      options: Closer::Drivers::Chrome.options
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
when :remote_chrome
  Capybara.register_driver :remote_chrome do |app|

    Capybara::Selenium::Driver.new(
      app,
      browser: :remote,
      url: 'http://127.0.0.1:4444/wd/hub',
      options: Closer::Drivers::Chrome.options
    )
  end
end
