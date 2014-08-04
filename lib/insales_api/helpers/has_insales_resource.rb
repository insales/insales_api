module InsalesApi::Helpers
  module HasInsalesResource
    included do
      class_attribute :insales_resource_class
      self.insales_resource_class = InsalesApi.const_get(name.demodulize) rescue nil
    end

    module ClassMethods
      def find_or_create_by_insales_resource(insales_resource, attrs = {})
        find_by_insales_resource(insales_resource) ||
          create_by_insales_resource(insales_resource, attrs)
      end

      def find_by_insales_resource(insales_resource)
        find_by_insales_id(insales_resource.id)
      end

      def create_by_insales_resource(insales_resource, attrs = {})
        new(attrs).update_by_insales_resource(insales_resource).save
      end
    end

    def insales_resource(force = false)
      return @insales_resource if @insales_resource && !force
      @insales_resource = init_api do
        insales_resource_class.find(insales_id)
      end
    end

    attr_writer :insales_resource

    def reload(*)
      @insales_resource = nil
      super
    end

    def update_by_insales_resource(insales_resource)

    end

    module DSL
      def has_insales_resource(options = {})
        include HasInsalesResource
        self.insales_resource_class = options[:class] if options[:class]
      end
    end
  end

  module TMP
    def has_insales_resource(*args)
      options = args.extract_options!
      type = args[0] || name.demodulize.underscore
      i_method_name = "insales_#{type}"
      class_method_name = "insales_#{type}_class"
      object_class = options[:class] || InsalesApi.const_get(type.to_s.camelcase)
      helpers = Module.new do
        extend ActiveSupport::Concern

        module_eval <<-RUBY, __FILE__, __LINE__ + 1
          module ClassMethods                                                   # module ClassMethods
            def find_or_create_by_#{i_method_name}(insales_object)              #   def find_or_create_by_insales_order(insales_object)
              find_by_#{i_method_name}(insales_object) ||                       #     find_by_insales_order(insales_object) ||
                create_by_#{i_method_name}(insales_object)                      #       create_by_insales_order(insales_object)
            end                                                                 #   end
                                                                                #
            def find_by_#{i_method_name}(insales_object)                        #   def find_by_insales_order(insales_object)
              find_by_insales_id(insales_object.id)                             #     find_by_insales_id(insales_object.id)
            end                                                                 #   end
                                                                                #
            def create_by_#{i_method_name}(insales_object)                      #   def create_by_insales_order(insales_object)
              new.update_by_#{i_method_name}(insales_object).save               #     new.update_by_insales_order(insales_object).save
            end                                                                 #   end
          end                                                                   # end
                                                                                #
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

          def update_by_#{i_method_name}(insales_object)

          end
        RUBY
      end
      include helpers
    end
  end
end
