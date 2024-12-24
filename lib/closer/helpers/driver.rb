require 'capybara'
require 'selenium-webdriver'

Dir::glob(File.join(File.dirname(__FILE__), 'drivers', '*.rb')).each do |file|
  require_relative "drivers/#{File.basename(file)}"
end

browser = ENV['DRIVER']
boottype = 'headless' if ENV['HEADLESS']
boottype = 'remote' if ENV['REMOTE'] # always headless
Capybara.default_driver = [boottype, browser].compact.join('_').to_sym

case browser
when 'chrome'
  case boottype
  when 'headless'
    Capybara.register_driver :headless_chrome do |app|
      Capybara::Selenium::Driver.new(
        app,
        browser: :chrome,
        options: Closer::Drivers::Chrome.options
      )
    end
  when 'remote'
    Capybara.register_driver :remote_chrome do |app|
      Capybara::Selenium::Driver.new(
        app,
        browser: :remote,
        url: 'http://127.0.0.1:4444/wd/hub',
        options: Closer::Drivers::Chrome.options
      )
    end
  else
    Capybara.register_driver :chrome do |app|
      driver = Capybara::Selenium::Driver.new(app,
        browser: :chrome
      )
    end
  end
when 'firefox'
  case boottype
  when 'headless'
    Capybara.register_driver :headless_firefox do |app|
      options = Selenium::WebDriver::Firefox::Options.new
      options.args << '--headless'

      Capybara::Selenium::Driver.new(
        app,
        browser: :firefox,
        options: options
      )
    end
  else
    Capybara.register_driver :firefox do |app|
      driver = Capybara::Selenium::Driver.new(
        app,
        browser: :firefox
      )
    end
  end
end
