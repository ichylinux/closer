module Closer
  require 'closer/version'
  require 'closer/config'

  def self.config
    @config ||= Closer::Config.new
  end

  require 'closer/filters'
  require 'closer/helpers'
end

if Closer.config.coverage_enabled?
  require 'simplecov'
  require 'simplecov-rcov'
  SimpleCov.formatter = SimpleCov::Formatter::RcovFormatter
  SimpleCov.command_name(ENV['COMMAND_NAME'] || 'Cucumber')
  SimpleCov.merge_timeout(Closer.config.merge_timeout)
  SimpleCov.start
end
