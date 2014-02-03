module Insales::Controller
  module InstallerActions
    def install
      if insales_app_class.install(params[:shop], params[:token], params[:insales_id])
        head :ok
      else
        raise 'Instalation failed'
      end
    end

    def uninstall
      if insales_app_class.uninstall(params[:shop], params[:token])
        head :ok
      else
        raise 'Uninstallation failed'
      end
    end
  end
end
