module InsalesApi
  class Product < Base
    def self.count
      connection.get('/admin/products/count.xml', headers).tap do |response|
        return response["count"]
      end
    end
  end
end
