module InsalesApi
  class Collect < Base
    def self.group_create product_ids, collection_ids
      connection.post("/admin/collects/group_create.xml?#{{:collection_ids => Array(collection_ids), :product_ids => Array(product_ids)}.to_query}", '', headers)
    end
  end
end
