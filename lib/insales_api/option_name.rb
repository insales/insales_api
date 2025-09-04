module InsalesApi
  class OptionName < Base
    def option_values
      InsalesApi::OptionValue.all(params: { option_name_id: id })
    end
  end
end
