Capybara.default_selector = :css
Capybara.server = :puma, {Silent: true} if defined?(Puma)
