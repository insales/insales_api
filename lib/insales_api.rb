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
    autoload :ClientGroup
    autoload :Collect
    autoload :Collection
    autoload :DeliveryVariant
    autoload :DiscountCode
    autoload :Domain
    autoload :Field
    autoload :File
    autoload :Image
    autoload :JsTag
    autoload :Notification
    autoload :OptionName
    autoload :OptionValue
    autoload :Order
    autoload :OrderLine
    autoload :Page
    autoload :PaymentGateway
    autoload :Product
    autoload :ProductField
    autoload :ProductFieldValue
    autoload :Property
    autoload :Characteristic
    autoload :RecurringApplicationCharge
    autoload :Theme
    autoload :User
    autoload :Variant
    autoload :Webhook
  end

  class << self
    # Calls the supplied block. If the block raises <tt>ActiveResource::ServerError</tt> with 503
    # code which means Insales API request limit is reached, it will wait for the amount of seconds
    # specified in 'Retry-After' response header. The called block will receive a parameter with
    # current attempt number.
    #
    # ==== Params:
    #
    #   +max_attempts+:: maximum number of attempts. Defaults to +nil+ (unlimited).
    #   +callback+:: +Proc+ or lambda to execute before waiting. Will receive four arguments: number
    #                of seconds we are going to wait, number of failed attempts, maximum number of
    #                attempts and the caught <tt>ActiveResource::ServerError</tt>. Defaults to +nil+
    #                (no callback).
    #
    # ==== Example
    #
    #   notify_user = Proc.new do |wait_for, attempt, max_attempts, ex|
    #     puts "API limit reached. Waiting for #{wait_for} seconds. Attempt #{attempt}/#{max_attempts}"
    #   end
    #
    #   InsalesApi.wait_retry(10, notify_user) do |x|
    #     puts "Attempt ##{x}."
    #     products = InsalesApi::Products.all
    #   end
    def wait_retry(max_attempts = nil, callback = nil, &block)
      attempts = 0

      begin
        attempts += 1
        yield attempts
      rescue ActiveResource::ServerError => ex
        raise ex if '503' != ex.response.code.to_s
        raise ex if max_attempts && attempts >= max_attempts
        retry_after = (ex.response['Retry-After'] || 150).to_i
        callback.call(retry_after, attempts, max_attempts, ex) if callback
        sleep(retry_after)
        retry
      end
    end
  end

end

require 'insales_api/helpers/init_api'
require 'insales_api/helpers/has_insales_object'

ActiveSupport.run_load_hooks(:insales_api, InsalesApi)
