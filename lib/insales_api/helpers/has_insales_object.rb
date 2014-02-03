module InsalesApi::Helpers
  module HasInsalesObject
    def has_insales_object(type, options = {})
      i_method_name = "insales_#{type}"
      class_method_name = "insales_#{type}_class"
      object_class = options[:class] || InsalesApi.const_get(type.to_s.camelcase)
      helpers = Module.new do
        extend ActiveSupport::Concern

        module_eval <<-RUBY, __FILE__, __LINE__ + 1
          included do                                                           # included do
            class_attribute :#{class_method_name}                               #   class_attribute :insales_order_class
            self.#{class_method_name} = #{object_class}                         #   self.insales_order_class = InsalesApi::Order
          end                                                                   # end
                                                                                #
          def #{i_method_name}(force = false)                                   # def insales_order(force = false)
            return @#{i_method_name} if @#{i_method_name} && !force             #   return @insales_order if @insales_order && !force
            @#{i_method_name} = init_api do                                     #   @insales_order = init_api do
              #{class_method_name}.find(insales_id)                             #     insales_order_class.find(insales_id)
            end                                                                 #   end
          end                                                                   # end
                                                                                #
          attr_writer :#{i_method_name}                                         # attr_writer :insales_order
                                                                                #
          def reload(*)                                                         # def reload(*)
            @#{i_method_name} = nil                                             #   @insales_order = nil
            super                                                               #   super
          end                                                                   # end
        RUBY
      end
      include helpers
    end
  end
end
