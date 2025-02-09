require 'capybara'
Capybara.default_selector = :css
Capybara.server = :puma, {Silent: true} if defined?(Puma)

Capybara.default_max_wait_time = Closer.config.default_max_wait_time

if Closer.config.remote?
  Capybara.server_host = '127.0.0.1'
  Capybara.server_port = '3000'
end
