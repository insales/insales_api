class Cpanel::InstallationsController < CpanelController
  include InsalesApi::Controller::InstallerActions
  skip_before_filter :insales_authenticate!
end
