module InsalesApi
  class Theme < Base
    has_many :assets, class_name: 'InsalesApi::Asset'
  end
end
