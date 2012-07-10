module InsalesApi
  class Category < Base
    def self.set_products_category new_category_id, products_ids
      connection.put('/admin/categories/set_products_category.xml', {:id => new_category_id, :product_ids => Array(products_ids)}.to_xml(:root => 'new_category'), headers)
    end
  end
end
