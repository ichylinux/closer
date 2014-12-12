require "closer/version"

if defined?(Rails)
  require 'closer/rails/engine'
  require 'closer/rails/railtie'
end

module Closer
end
