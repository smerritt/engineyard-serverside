module EY::Platform
  class AppCloud < Base
    register_as 'appcloud'

    def migration_running_roles
      [ :app_master, :solo ]
    end

    def app_server_roles
      [:app_master, :app, :solo]
    end

    def restart_command
      "/engineyard/bin/app_#{deploy.config.app} deploy"
    end

  end
end
