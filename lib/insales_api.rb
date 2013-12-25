require 'active_support/core_ext'
require 'active_resource'
# backport from 4.0
require 'active_resource/singleton' unless ActiveResource.const_defined?(:Singleton, false)
require 'digest/md5'

module InsalesApi
  extend ActiveSupport::Autoload

  eager_autoload do
    autoload :Version
    autoload :App
    autoload :Password

    autoload :Base
    autoload :Account
    autoload :Category
    autoload :Client
    autoload :Collection
    autoload :Collect
    autoload :OptionName
    autoload :OptionValue
    autoload :Product
    autoload :Variant
    autoload :Image
    autoload :Webhook
    autoload :Order
    autoload :OrderLine
    autoload :ApplicationWidget
    autoload :Field
    autoload :DeliveryVariant
    autoload :PaymentGateway
    autoload :JsTag
    autoload :Domain
    autoload :Page
    autoload :Theme
    autoload :Asset
    autoload :ApplicationCharge
    autoload :RecurringApplicationCharge
    autoload :File
  end
end
