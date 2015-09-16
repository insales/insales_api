module InsalesApi
  class App
    class_attribute :api_key, :api_secret, :api_autologin_url, :api_host, :api_autologin_path,
      :base_resource_class
    attr_reader :authorized, :domain, :password
    self.base_resource_class = Base

    class << self
      def configure_api(domain, password)
        base_resource_class.configure(api_key, domain, password)
      end

      delegate :dump_config, :restore_config, to: :base_resource_class

      def prepare_domain(domain)
        domain.to_s.strip.downcase
      end

      alias_method :prepare_shop, :prepare_domain
      deprecate prepare_shop: :prepare_domain,
        api_host: :api_autologin_url,
        api_autologin_path: :api_autologin_url,
        deprecator: Deprecator

      def install(domain, token, insales_id)
        true
      end

      def uninstall(domain, password)
        true
      end

      def password_by_token(token)
        InsalesApi::Password.create(api_secret, token)
      end
    end

    def initialize(domain, password)
      @authorized = false
      @domain     = self.class.prepare_domain(domain)
      @password   = password
    end

    def authorization_url
      host, port = domain, nil
      match = /(.+):(\d+)/.match host
      host, port = match[1..2] if match
      URI::Generic.build(
        scheme:   'http',
        host:     host,
        port:     port && port.to_i,
        path:     "/admin/applications/#{api_key}/login",
        query:    {
          token:  salt,
          login:  api_autologin_url || "http://#{api_host}/#{api_autologin_path}",
        }.to_query,
      ).to_s
    end

    def auth_token(user_email = '', user_name = '', user_id = '')
      @auth_token ||= InsalesApi::Password.create(password, salt, user_email, user_name, user_id)
    end

    def salt
      @salt ||= SecureRandom.hex
    end

    def authorize(token)
      @authorized = auth_token == token
    end

    def authorized?
      @authorized
    end

    def configure_api
      self.class.configure_api(domain, password)
    end

    alias_method :store_auth_token, :auth_token
    alias_method :shop, :domain
    deprecate store_auth_token: :auth_token, shop: :domain, deprecator: Deprecator
  end
end
