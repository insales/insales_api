module InsalesApi
  class Variant < Base
    GROUP_UPDATE_PATH = '/admin/products/variants_group_update.xml'
    self.prefix = '/admin/products/:product_id/'

    class << self
      # Выполняет обновление всех переданных модификаций.
      # variants - массив c модицикациями в формате
      #
      #   [
      #     {
      #       id: 1,
      #       price: 340,
      #       quantity: 4,
      #     },
      #     {
      #       id: 2,
      #       price: 350,
      #       quantity: 5,
      #     },
      #   ]
      def group_update(variants)
        connection.put(GROUP_UPDATE_PATH, variants.to_xml(root: :variants), headers)
      end
    end
  end
end
