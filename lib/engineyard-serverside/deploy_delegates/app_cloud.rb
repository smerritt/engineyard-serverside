module EY::DeployDelegate
  class AppCloud < Base
    register 'appcloud'

    def migration_running_roles
      [ :app_master, :solo ]
    end

    def app_server_roles
      [:app_master, :app, :solo]
    end

    def restart
      deploy.run("/engineyard/bin/app_#{deploy.config.app} deploy")
    end

  end
end
