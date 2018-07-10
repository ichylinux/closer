require 'capybara'
require_relative 'drivers/file_detector'

Capybara.default_driver = (ENV['DRIVER'] || 'firefox').to_sym

case Capybara.default_driver
when :chrome
  if ENV['CI'] == 'travis'
    caps = Selenium::WebDriver::Remote::Capabilities.chrome(
      'tunnel-identifier' => ENV['TRAVIS_JOB_NUMBER']
    )
  
    Capybara.register_driver :chrome do |app|
      driver = Capybara::Selenium::Driver.new(app,
        :browser => :remote,
        :url => "http://#{ENV['SAUCE_USERNAME']}:#{ENV['SAUCE_ACCESS_KEY']}@ondemand.saucelabs.com/wd/hub",
        :desired_capabilities => caps
      )

      Closer::Drivers::FileDetector.apply(driver)
    end
  else
    Capybara.register_driver :chrome do |app|
      driver = Capybara::Selenium::Driver.new(app,
        :browser => :chrome
      )
    end
  end
when :firefox
  if ENV['CI'] == 'travis'
    caps = Selenium::WebDriver::Remote::Capabilities.firefox(
      'tunnel-identifier' => ENV['TRAVIS_JOB_NUMBER']
    )
  
    Capybara.register_driver :firefox do |app|
      driver = Capybara::Selenium::Driver.new(app,
        :browser => :remote,
        :url => "http://#{ENV['SAUCE_USERNAME']}:#{ENV['SAUCE_ACCESS_KEY']}@ondemand.saucelabs.com/wd/hub",
        :desired_capabilities => caps
      )

      Closer::Drivers::FileDetector.apply(driver)
    end
  else
    Capybara.register_driver :firefox do |app|
      driver = Capybara::Selenium::Driver.new(app,
        browser: :firefox
      )
    end
  end
when :headless_chrome
  Capybara.register_driver :headless_chrome do |app|
    capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
      chromeOptions: { args: %w[headless disable-gpu window-size=1280,720] }
    )
    Capybara::Selenium::Driver.new(
      app,
      browser: :chrome,
      desired_capabilities: capabilities
    )
  end
when :poltergeist
  require 'capybara/poltergeist'

  Capybara.register_driver :poltergeist do |app|
    Capybara::Poltergeist::Driver.new(app, timeout: 60)
  end
end
