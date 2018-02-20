require 'closer/version'
require 'closer/config'

module Closer

  def self.config
    @config ||= Closer::Config.new
  end

end

if Closer.config.coverage_enabled?
  require 'simplecov'
  require 'simplecov-rcov'
  require 'closer/coverage/rcov_formatter'
  SimpleCov.formatter = Closer::Coverage::RcovFormatter
  SimpleCov.command_name(ENV['COMMAND_NAME'] || 'Cucumber')
  SimpleCov.merge_timeout(Closer.config.merge_timeout)
  SimpleCov.start
end
