module InsalesApi
  class Theme < Base

    def assets
      InsalesApi::Asset.all(params: {theme_id: id})
    end

  end
end
