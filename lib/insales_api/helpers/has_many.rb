module InsalesApi::Helpers
  module HasMany
    def has_many_insales(model, options = {})
      model_singular = model.to_s.singularize
      resource_class = options[:class] || InsalesApi.const_get(model_singular.camelcase)
      collection_method_name = "insales_#{model}"

      define_method collection_method_name do |*args|
        resource_class
      end

      init_api_for collection_method_name
    end
  end
end
