require "closer/version"

if defined?(Rails)
  require 'closer/rails/engine'
  require 'closer/rails/railtie'
end

module Closer

  def self.config
    @@config ||= Closer::Config.new
  end
end
