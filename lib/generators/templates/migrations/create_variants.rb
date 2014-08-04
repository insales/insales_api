require 'foreigner'
Foreigner.load

class CreateVariants < ActiveRecord::Migration
  def change
    create_table :variants do |t|
      t.integer     :insales_id,          null: false
      t.references  :product,             null: false

      t.timestamps

      t.index :insales_id
      t.index :product_id

      t.foreign_key :products
    end
  end
end
