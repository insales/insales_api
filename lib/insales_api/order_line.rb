module InsalesApi
  class OrderLine < Base
    self.prefix = "#{prefix}orders/:order_id/"
  end
end
