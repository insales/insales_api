class Order < ActiveRecord::Base
  belongs_to :account, inverse_of: :orders
  belongs_to :client, inverse_of: :orders
  has_many :order_lines, inverse_of: :order, dependent: :destroy
  has_insales_resource

  extend InsalesApi::Helpers::InitApi::ClassMethods
  delegate :init_api, to: :account
end
