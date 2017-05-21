require 'closer/version'
require 'closer/config'
#require 'closer/cucumber_patch'

module Closer

  def self.config
    @config ||= Closer::Config.new
  end

end

if Closer.config.coverage_enabled?
  require 'simplecov'
  require 'simplecov-rcov'
  SimpleCov.formatter = SimpleCov::Formatter::RcovFormatter
  SimpleCov.command_name(ENV['COMMAND_NAME'] || 'Cucumber')
  SimpleCov.merge_timeout(Closer.config.merge_timeout)
  SimpleCov.start
end
