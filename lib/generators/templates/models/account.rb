class Account < ActiveRecord::Base
  has_many :orders, inverse_of: :account, dependent: :destroy
  has_many :products, inverse_of: :account, dependent: :destroy
  has_many :variants, through: :products
  has_insales_resource

  include InsalesApi::Helpers::InitApi
end
