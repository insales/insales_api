class Product < ActiveRecord::Base
  belongs_to :account, inverse_of: :products
  has_many :variants, inverse_of: :product, dependent: :destroy
  has_insales_resource

  extend InsalesApi::Helpers::InitApi::ClassMethods
  delegate :init_api, to: :account
end