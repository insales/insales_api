module InsalesApi
  class Property < Base
    def characteristics
      InsalesApi::Characteristic.all(params: { property_id: id } )
    end
  end
end
