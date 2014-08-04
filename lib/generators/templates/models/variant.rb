class Variants < ActiveRecord::Base
  belongs_to :product, inverse_of: :variants
  has_insales_resource

  extend InsalesApi::Helpers::InitApi::ClassMethods
  delegate :account, to: :product
  delegate :init_api, to: :account
end