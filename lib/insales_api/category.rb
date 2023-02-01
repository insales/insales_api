module InsalesApi
  class Category < Base
    extend Resource::WithUpdatedSince
    class << self
      def set_products_category(new_category_id, product_ids)
        data = {
          id: new_category_id,
          product_ids: Array(product_ids),
        }
        put(:set_products_category, {}, format.encode(data, root: :new_category))
      end
    end
  end
end
