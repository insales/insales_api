require 'foreigner'
Foreigner.load

class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.integer     :insales_id,          null: false
      t.references  :account,             null: false

      t.timestamps

      t.index       :insales_id
      t.index       :account_id

      t.foreign_key :accounts
    end
  end
end
