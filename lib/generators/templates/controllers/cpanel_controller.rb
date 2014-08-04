require 'insales'

class CpanelController < ApplicationController
  include Insales::Controller::BaseHelpers
  include Insales::Controller::Autologin

  self.insales_config = insales_config.merge(
    login_path:           :new_cpanel_session_path,
    success_login_path:   :cpanel_account_path,
  )

  abstract!
  before_filter :insales_authenticate!
  layout 'cpanel'
end
