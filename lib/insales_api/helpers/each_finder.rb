module InsalesApi::Helpers
  module EachFinder
    def each_finder_for(model, settings = {})
      model_singular = model.singularize
      resource_class = settings[:class] || InsalesApi.const_get(model_singular.camelcase)

      define_metod "find_insales_#{model}_in_batches" do |options = {}|
        options[:per_page] ||= settings[:per_page] if settings[:per_page]
        resource_class.find_in_batches(options) { |items| yield items
        end
      end

      define_metod "find_each_insales_#{model_singular}" do |*args|
        find_insales_products_in_batches(*args) do |batch|
          batch.each { |record| yield record }
        end
      end

    end
  end
end
