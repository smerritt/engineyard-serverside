module EY::DeployDelegate
  class AppCloud < Base
    register 'appcloud'

    def migrate_roles
      [ :app_master, :solo ]
    end

    def maintenance_page_roles
      restart_roles
    end

    def restart_roles
      [:app_master, :app, :solo]
    end

    def restart
      deploy.run("/engineyard/bin/app_#{deploy.config.app} deploy")
    end

  end
end
