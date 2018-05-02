module InsalesApi
  module Resource
    module Countable
      def count(options = {})
        get(:count, options)['count'].to_i
      end
    end
  end
end
