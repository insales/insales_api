class Client < ActiveRecord::Base
  belongs_to :account, inverse_of: :clients
  has_many :orders, inverse_of: :client
  has_insales_resource

  extend InsalesApi::Helpers::InitApi::ClassMethods
  delegate :init_api, to: :account
end
