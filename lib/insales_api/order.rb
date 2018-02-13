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
      serialized_options = options.dup
      if respond_to? :order_lines_attributes
        serialized_options[:methods] = :order_lines_attributes
      end
      super(serialized_options)
    end

    def paid?
      financial_status == 'paid'
    end
  end
end
