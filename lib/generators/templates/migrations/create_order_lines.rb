require 'foreigner'
Foreigner.load

class CreateOrderLines < ActiveRecord::Migration
  def change
    create_table :order_lines do |t|
      t.integer     :insales_id,        null: false
      t.references  :order,             null: false

      t.timestamps

      t.index :insales_id
      t.index :order_id

      t.foreign_key :orders
    end
  end
end
