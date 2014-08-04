module Insales::Controller
  module Autologin
    protected
      def insales_authenticate!
        params[:domain] ||= params[:shop]
        insales_logout if params[:domain].present? && params[:domain] != session[:domain]
        return if insales_authenticate_from_session
        store_location
        account = insales_login_form.account
        return insales_autologin_start(account) if account
        redirect_to insales_login_path
      end

      def insales_authenticate_from_session
        return @account = account_class.first
        data = session[:insales_session]
        return unless data && data[:account_id] && data[:insales_id]
        @account = account_class.where(account_id: data[:account_id]).
          find_by_insales_id(data[:insales_id])
      end

      def insales_autologin_start(account)
        app = insales_app_class.new(account.insales_domain, account.insales_password)
        auth_url = app.authorization_url
        session[:insales_token] = app.auth_token
        session[:insales_token_data] = {
          domain:       account.insales_domain,
          account_id:   account.id,
          insales_id:   account.insales_id,
        }
        redirect_to auth_url
      end

      def insales_autologin_finish(token = params[:token])
        if token && session[:insales_token] == token && session[:insales_token_data].is_a?(Hash)
          session[:insales_session] = session[:insales_token_data]
        end
        session[:insales_token] = session[:insales_token_data] = nil
        session[:account_id].present?
      end

      def insales_logout
        session.delete(:insales_session)
      end
  end
end
