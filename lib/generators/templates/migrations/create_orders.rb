require 'foreigner'
Foreigner.load

class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer     :insales_id,        null: false
      t.references  :account,           null: false
      t.references  :client

      t.timestamps

      t.index :insales_id
      t.index :account_id
      t.index :client_id

      t.foreign_key :accounts
      t.foreign_key :clients
    end
  end
end
