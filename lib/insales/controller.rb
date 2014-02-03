module Insales
  module Controller
    extend ActiveSupport::Autoload

    autoload :BaseHelpers
    autoload :Autologin
    autoload :SessionActions
    autoload :InstallerActions
  end
end
