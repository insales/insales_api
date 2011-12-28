require 'digest/md5'
module InsalesApi
  class App
    cattr_accessor :api_key, :api_host, :api_secret, :api_autologin_path
    attr_accessor :shop, :password, :authorized, :auth_token

    def initialize(shop, password)
      @authorized = false
      @shop       = self.class.prepare_shop shop
      @password   = password
    end

    def authorization_url
      store_auth_token
      "http://#{shop}/admin/applications/#{self.class.api_key}/login?token=#{salt}&login=http://#{self.class.api_host}/#{self.class.api_autologin_path}"
    end

    def store_auth_token
      @auth_token = InsalesApi::Password.create(password, salt)
    end

    def salt
      @salt ||= Digest::MD5.hexdigest("Twulvyeik#{$$}#{Time.now.to_i}thithAwn")
    end

    def authorize token
      @authorized = false
      if self.auth_token == token
        @authorized = true
      end

      @authorized
    end

    def authorized?
      @authorized
    end

    def configure_api
      self.class.configure_api shop, password
    end

    class << self
      def configure_api shop, password
        InsalesApi::Base.configure api_key, shop, password
      end

      def prepare_shop shop
        shop.to_s.strip.downcase
      end

      def install shop, token, insales_id
        true
      end

      def uninstall shop, password
        true
      end

      def password_by_token token
        InsalesApi::Password.create(api_secret, token)
      end
    end
  end
end
