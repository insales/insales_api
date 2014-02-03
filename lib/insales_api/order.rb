module InsalesApi
  class Order < Base
    extend Resource::WithUpdatedSince

    def order_lines_attributes
      @order_lines_attributes = order_lines.map do |order_line|
        order_line.as_json['order_line']
      end
    end

    def to_xml(options = {})
      super(options.merge(methods: :order_lines_attributes))
    end

    def paid?
      financial_status == 'paid'
    end
  end
end
