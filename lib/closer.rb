require 'closer/version'
require 'closer/config'
#require 'closer/cucumber_patch'

module Closer

  def self.config
    @config ||= Closer::Config.new
  end

end

true_values = %w{ true t yes y 1 }
coverage_enabled = true_values.include?(ENV["COVERAGE"].to_s.downcase) and true_values.include?(ENV['ACCEPTANCE_TEST'].to_s.downcase)

if coverage_enabled
  require 'simplecov'
  require 'simplecov-rcov'
  SimpleCov.formatter = SimpleCov::Formatter::RcovFormatter
  SimpleCov.command_name(ENV['COMMAND_NAME'] || 'Cucumber')
  SimpleCov.merge_timeout(Closer.config.merge_timeout)
  SimpleCov.start
end

