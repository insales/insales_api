module InsalesApi
  class ProductFieldValue < Base
    self.prefix = "#{prefix}products/:product_id/"

    class << self
      def find_by_field_id(params)
        field_id = params[:product_field_id]
        all(params: { product_id: params[:product_id] })
          .find { |x| x.product_field_id == field_id }
      end

      def create_or_update(params)
        if (value = find_by_field_id(params))
          value.update_attribute(:value, params[:value])
          value
        else
          create(params)
        end
      end
    end
  end
end
