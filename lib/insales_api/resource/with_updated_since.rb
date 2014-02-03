module InsalesApi
  module Resource
    module WithUpdatedSince
      def find_in_batches(options = {}, &block)
        return super unless updated_since = options.delete(:updated_since)
        find_updated_since(updated_since, options, &block)
      end

      def find_updated_since(updated_since, options = {})
        per_page = options[:per_page] || PER_PAGE_DEFAULT
        params    = { per_page: per_page }.merge(options[:params] || {})
        last_id   = nil
        loop do
          items = all(params: params.merge(
            updated_since:  updated_since,
            from_id:        last_id,
          ))
          return unless items.any?
          yield items
          return if items.count < per_page
          last_item     = items.last
          last_id       = last_item.id
          updated_since = last_item.updated_at
        end
      end
    end
  end
end
