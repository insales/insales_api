module InsalesApi
  class Account < Base
    def self.current
      find(:one, :from => '/admin/account.xml')
    end

    def update
      connection.put('/admin/account.xml', encode, self.class.headers).tap do |response|
        load_attributes_from_response(response)
      end
    end
  end
end
