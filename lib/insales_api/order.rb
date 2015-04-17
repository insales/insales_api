# coding: utf-8
module InsalesApi
  class Order < Base
    extend Resource::WithUpdatedSince

    def order_lines_attributes
      @order_lines_attributes = order_lines.map do |order_line|
        ol = order_line.as_json
        # при смене версии рельсов (видимо) изменилась сериализация
        ol = ol['order_line'] if ol['order_line']
        ol
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
