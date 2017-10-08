require 'closer/drivers/file_detector'

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

      Closer::Drivers::FileDetector.apply(driver)
    end
  end
when :poltergeist
  require 'capybara/poltergeist'
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
        :browser => :firefox
      )

      Closer::Drivers::FileDetector.apply(driver)
    end
  end
end
