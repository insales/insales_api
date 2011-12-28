module InsalesApi
  class Base < ActiveResource::Base
    self.format = :xml

    def self.configure(api_key, shop, password)
      self.user     = api_key
      self.site     = "http://#{shop}/admin/"
      self.password = password
      return
    end
  end
end
