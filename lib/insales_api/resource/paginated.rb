module InsalesApi
  PER_PAGE_DEFAULT = 100

  module Resource
    module Paginated
      def find_each(*args)
        find_in_batches(*args) do |batch|
          batch.each { |record| yield record }
        end
      end

      def find_in_batches(options = {})
        per_page = options[:per_page] || PER_PAGE_DEFAULT
        params = {per_page: per_page}.merge(options[:params] || {})
        page = 1
        loop do
          items = all(params: params.merge(page: page))
          return unless items.any?
          yield items
          return if items.count < per_page
          page += 1
        end
      end
    end
  end
end
