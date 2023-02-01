module Insales::Controller
  module BaseHelpers
    extend ActiveSupport::Concern

    included do
      class_attribute :insales_config
      self.insales_config = {
        account_class: '::Account',
        insales_app_class: '::InsalesApi::App',
        login_path: 'login_path',
        success_login_path: 'account_path',
      }

      def account_class
        @account_class ||= insales_config[:account_class].constantize
      end

      def insales_app_class
        @insales_app_class ||= insales_config[:insales_app_class].constantize
      end

      def insales_login_path
        send(insales_config[:login_path])
      end

      def insales_success_login_path
        send(insales_config[:success_login_path])
      end
    end

    protected

    delegate :insales_app_class, :account_class,
             :insales_login_path, :insales_success_login_path,
             to: :class

    def store_location(path = request.url)
      session[:return_to] = path
    end

    def stored_location
      session.delete(:return_to)
    end

    def find_account_by_request
      if params[:insales_id]
        account_class.find_by_insales_id(params[:insales_id])
      elsif params[:domain]
        account_class.find_by_insales_domain(params[:domain])
      end
    end
  end
end
