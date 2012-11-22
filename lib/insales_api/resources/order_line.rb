module InsalesApi
  class OrderLine < Base
    self.prefix = '/admin/orders/:order_id/'
  end
end