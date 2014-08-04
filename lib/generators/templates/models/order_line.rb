class OrderLine < ActiveRecord::Base
  belongs_to :order, inverse_of: :order_lines
  has_insales_resource

  extend InsalesApi::Helpers::InitApi::ClassMethods
  delegate :account, to: :order
  delegate :init_api, to: :account
end
