require "closer/version"
require "closer/config"

module Closer

  def self.config
    @@config ||= Closer::Config.new
  end

end

if defined?(Rails)
  require 'closer/rails/engine'
  require 'closer/rails/railtie'
end

require_relative 'helpers'
