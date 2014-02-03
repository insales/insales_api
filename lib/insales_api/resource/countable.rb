module InsalesApi
  module Resource
    module Countable
      def count(options = {})
        get(:count, options).to_i
      end
    end
  end
end
