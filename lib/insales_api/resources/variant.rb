module InsalesApi
  class Variant < Base
    self.prefix = "/admin/products/:product_id/"

    # variants_attrs - массив c модицикациями в формате [{:id => 1, :price => 340, :quantity => 4}, {:id => 2, :price => 350, :quantity => 5}]
    def self.group_update variants_attrs
      connection.put("/admin/products/variants_group_update.xml", { :variants => variants_attrs }.to_xml, headers)
    end

  end
end
