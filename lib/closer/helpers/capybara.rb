require 'capybara'
Capybara.default_selector = :css
Capybara.server = :puma, {Silent: true} if defined?(Puma)

if ENV['REMOTE']
  Capybara.server_host = '127.0.0.1'
  Capybara.server_port = '3000'
end
