module Closer
  module Rails
    class Railtie < ::Rails::Railtie

      rake_tasks do
        require 'closer/tasks'
      end

    end
  end
end
