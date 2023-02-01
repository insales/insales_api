module InsalesApi::Helpers
  module InitApi
    extend ActiveSupport::Concern

    included do
      class_attribute :insales_app_class
      self.insales_app_class = InsalesApi::App
    end

    module ClassMethods
      # Wraps methods into +init_api+ block. So you can be sure that method
      # will run for certain account.
      #
      #   class Account < ActiveRecord::Base
      #     include InsalesApi::Helpers
      #
      #     def find_products_by_name(name)
      #       # ...
      #     end
      #
      #     init_api_for :find_products_by_name
      #   end
      #
      #   account1 = Account.find(1)
      #   account2 = Account.find(2)
      #
      #   products1 = account1.find_products_by_name('smth')
      #   products2 = account2.find_products_by_name('smth_else')
      #
      #   # instead of
      #   # products1 = account1.init_api { find_products_by_name('smth') }
      #   # products2 = account2.init_api { find_products_by_name('smth_else') }
      #
      # Can be used in nessted classes like this:
      #
      #   class Order < ActiveRecord::Base
      #     extend InsalesApi::Helpers::ClassMethods
      #
      #     belongs_to :account
      #
      #     delegate :init_api, to: :account
      #
      #     def insales_order
      #       InsalesApi::Order.find(insales_id)
      #     end
      #
      #     init_api_for :insales_order
      #   end
      #
      #   insales_order = Order.first.insales_order
      #
      def init_api_for(*methods)
        file, line = caller.first.split(':', 2)
        methods.each do |method|
          alias_method_chain method, :init_api do |target, punct|
            class_eval <<-RUBY, file, line.to_i - 1
              def #{target}_with_init_api#{punct}(*args, &block)                # def sell_with_init_api(*args, &block)
                init_api { #{target}_without_init_api#{punct}(*args, &block) }  #   init_api { sell_without_init_api(*args, &block) }
              end                                                               # end
            RUBY
          end
        end
      end
    end

    # Configures api with credentials taken from +self.insales_domain+ and
    # +self.insales_password+.
    #
    # If block is given, it is evaluated and its result is returned.
    # After this old configuration is restored.
    #
    #   account1 = Account.find(1)
    #   account2 = Account.find(2)
    #
    #   account1.init_api
    #   # account1 credentials are used
    #   product1 = InsalesApi::Product.find(1)
    #   # will search within second account
    #   product2 = account2.init_api { InsalesApi::Product.find(2) }
    #   # configuration is restored
    #   variant1 = InsalesApi::Variants.find(1)
    #
    def init_api
      if block_given?
        old_config = insales_app_class.dump_config
        begin
          init_api
          yield
        ensure
          insales_app_class.restore_config(old_config)
        end
      else
        insales_app_class.configure_api(insales_domain, insales_password)
        self
      end
    end
  end
end
