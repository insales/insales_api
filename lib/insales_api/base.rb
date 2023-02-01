require 'insales_api/resource/countable'
require 'insales_api/resource/paginated'
require 'insales_api/resource/with_updated_since'
require 'insales_api/active_resource_proxy'

module InsalesApi
  class Base < ActiveResource::Base
    extend Resource::Countable
    extend Resource::Paginated

    self.include_root_in_json = false
    self.headers['User-Agent'] = %W(
      InsalesApi/#{InsalesApi::VERSION}
      ActiveResource/#{ActiveResource::VERSION::STRING}
      Ruby/#{RUBY_VERSION}
    ).join(' ')
    self.format = :xml
    self.prefix = '/admin/'

    class << self
      def configure(api_key, domain, password)
        self.user     = api_key
        self.site     = "http://#{domain}"
        self.password = password
        self
      end

      def dump_config
        {
          user: self.user,
          site: self.site,
          password: self.password,
        }
      end

      def restore_config(options)
        self.user     = options[:user]
        self.site     = options[:site]
        self.password = options[:password]
        true
      end

      def for_account(account)
        ActiveResourceProxy.new(account, self)
      end
    end
  end
end
