module InsalesApi
  class Collect < Base
    class << self
      def group_create(product_ids, collection_ids)
        data = {
          collection_ids: Array(collection_ids),
          product_ids:    Array(product_ids),
        }
        post(:group_create, {}, format.encode(data, root: :group_create))
      end
    end
  end
end
