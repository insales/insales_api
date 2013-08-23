module InsalesApi
  class Order < Base
    def order_lines_attributes
      @order_lines_attributes = []
      order_lines.each do |order_line|
        @order_lines_attributes << order_line.as_json['order_line']
      end
      @order_lines_attributes
    end

    def to_xml(options = {})
      super(options.merge({:methods => :order_lines_attributes}))
    end
  end
end
