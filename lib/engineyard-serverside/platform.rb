module EY
  module Platform

    @@platforms = {}

    def self.for(name, config)
      platform_klass = @@platforms[name] or raise ArgumentError, "No platform named #{name}; availble platforms are #{@@platforms.keys.join(', ')}"
      platform_klass.new(config)
    end

    def self.register(name, klass)
      @@platforms[name] = klass
    end

    class Base
      def self.register_as(name)
        Module.nesting[1].register(name, self)
      end

      attr_reader :config

      def initialize(config)
        @config = config
      end

      def migration_running_roles
        raise NotImplementedError
      end

      def app_server_roles
        raise NotImplementedError
      end

    end
  end
end

require "engineyard-serverside/platform/app_cloud"
