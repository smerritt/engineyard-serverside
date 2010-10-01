module EY
  module DeployDelegate
    @@delegate_map ||= {}

    def self.for(deploy)
      infra, stack = deploy.config['infrastructure'], deploy.config['stack']

      if found = [ [infra,stack].join('/'), infra.to_s ].detect { |key| @@delegate_map.has_key?(key) }
        @@delegate_map[found].new(deploy)
      else
        raise "Unable to find suitable delegate for #{infra}/#{stack} options are #{@@delegate_map.keys.join(', ')}"
      end
    end

    def self.register(klass, infra, stack=nil)
      @@delegate_map[[infra, stack].compact.join('/')] = klass
    end

    class Base
      def self.register(*args)
        DeployDelegate.register(self, *args)
      end

      attr_reader :deploy

      def initialize(deploy)
        @deploy = deploy
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

require File.join(File.dirname(__FILE__), 'deploy_delegates', 'app_cloud')
