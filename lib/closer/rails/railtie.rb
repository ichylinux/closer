true_values = %w{ true t 1 }
if true_values.include?(ENV["COVERAGE"].to_s.downcase) and true_values.include?(ENV['ACCEPTANCE_TEST'].to_s.downcase)
  require 'simplecov'
  require 'simplecov-rcov'
  SimpleCov.formatter = SimpleCov::Formatter::RcovFormatter
  SimpleCov.command_name(ENV['COMMAND_NAME'] || 'Cucumber')
  SimpleCov.merge_timeout(3600)
  SimpleCov.start 'rails'
end

module Closer
  module Rails
    class Railtie < ::Rails::Railtie
    end
  end
end
