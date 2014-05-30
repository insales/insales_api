require 'digest/md5'
require 'active_support'
require 'active_support/core_ext'
require 'active_resource'
# backport from 4.0
require 'active_resource/singleton' unless ActiveResource.const_defined?(:Singleton, false)

module InsalesApi
  extend ActiveSupport::Autoload

  Deprecator = ActiveSupport::Deprecation.new('1.0', name)

  eager_autoload do
    autoload :VERSION
    autoload :Base
    autoload :Password
    autoload :App

    autoload :Account
    autoload :ApplicationCharge
    autoload :ApplicationWidget
    autoload :Asset
    autoload :Category
    autoload :Client
    autoload :Collect
    autoload :Collection
    autoload :DeliveryVariant
    autoload :DiscountCode
    autoload :Domain
    autoload :Field
    autoload :File
    autoload :Image
    autoload :JsTag
    autoload :OptionName
    autoload :OptionValue
    autoload :Order
    autoload :OrderLine
    autoload :Page
    autoload :PaymentGateway
    autoload :Product
    autoload :ProductFieldValue
    autoload :RecurringApplicationCharge
    autoload :Theme
    autoload :Variant
    autoload :Webhook
  end
end

require 'insales_api/helpers/init_api'
require 'insales_api/helpers/has_insales_object'

ActiveSupport.run_load_hooks(:insales_api, InsalesApi)
