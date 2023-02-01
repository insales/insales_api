# frozen_string_literal: true

module InsalesApi
  class PriceKind < Base
    def variant_price_method_name
      "price#{price_index + 1}"
    end
  end
end
