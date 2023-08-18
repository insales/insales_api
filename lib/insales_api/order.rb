# frozen_string_literal: true

module InsalesApi
  class Order < Base
    extend Resource::WithUpdatedSince; end
end
