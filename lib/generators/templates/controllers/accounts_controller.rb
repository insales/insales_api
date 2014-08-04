class Cpanel::AccountsController < CpanelController
  inherit_resources
  defaults singleton: true
  actions :show, :update

  protected
    def resource
      @account
    end

    # def permitted_params
    #   params.permit(account: [:some_option])
    # end
end
