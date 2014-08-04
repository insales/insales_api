ActiveSupport.on_load(:insales_api) do
  self::Base.logger = ActiveRecord::Base.logger
  ActiveRecord::Base.extend self::Helpers::HasInsalesObject

  require File.join(Rails.root, 'lib', 'insales_api_patch')
end
