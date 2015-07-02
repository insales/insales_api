module InsalesApi
  module Resource
    module WithUpdatedSince
      def find_in_batches(options = {}, &block)
        return super unless updated_since = options.delete(:updated_since)
        find_updated_since(updated_since, options, &block)
      end

      def find_updated_since(updated_since = nil, options = {})
        limit = options[:per_page] || PER_PAGE_DEFAULT
        updated_since ||= '2008-01-01'.to_date

        # Сюда мы будем складывать товары с одинаковым updated_at.
        # Для исключения дубликатов, а они могут быть при перелиствыании,
        # Используем Hash
        current_products = {}
        page = 1

        while true
          Rails.logger.info "#{updated_since} #{page}"
          insales_products = InsalesApi::Product.all(
            params: {
              with_deleted: 1, updated_since: updated_since, limit: limit, page: page
            }.merge(options[:params] || {})
          )

          # Если товары с одинаковым updated_at, не поместились на страницу.
          # То мы для их выбора используем page. При обновлении товаров с ранее выбранных странц
          # из-за смещения товаров между страницами мы можем теряем часть товаров.
          if page > 1 && !current_products.empty? && !insales_products.size.zero? &&
             current_products[insales_products.first.id]

            page = 1
            next
          end

          # На случай если updated_at у всех товаров одинаковый готовимся прочесть следующую cтраницу.
          page += 1

          insales_products.each do |insales_product|
            updated_at = insales_product.updated_at.to_datetime
            if updated_at > updated_since
              updated_since = updated_at

              yield current_products.values

              # Если updated_since изменился, то нет смысла мотать страницы
              current_products = {}
              page = 1
            end

            current_products[insales_product.id] = insales_product
          end

          if insales_products.size < limit
            yield current_products.values
            break
          end
        end
      end
    end
  end
end
