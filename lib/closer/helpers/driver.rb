Capybara.default_driver = (ENV['DRIVER'] || 'selenium').to_sym

case Capybara.default_driver
when :chrome
  Capybara.register_driver :chrome do |app|
    driver = Capybara::Selenium::Driver.new(app,
      :browser => :chrome
    )
  end
when :poltergeist
  require 'capybara/poltergeist'
when :selenium
  if ENV['CI'] == 'travis'
    caps = Selenium::WebDriver::Remote::Capabilities.chrome(
      'tunnel-identifier' => ENV['TRAVIS_JOB_NUMBER']
    )
  
    Capybara.register_driver :selenium do |app|
      driver = Capybara::Selenium::Driver.new(app,
        :browser => :remote,
        :url => "http://#{ENV['SAUCE_USERNAME']}:#{ENV['SAUCE_ACCESS_KEY']}@ondemand.saucelabs.com/wd/hub",
        :desired_capabilities => caps
      )

      driver.browser.file_detector = lambda do |args|
        str = args.first.to_s
        str if File.exist?(str)
      end
      
      driver
    end
  end
end
