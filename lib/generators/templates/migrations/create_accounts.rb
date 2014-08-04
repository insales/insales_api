class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.integer     :insales_id,          null: false
      t.string      :insales_domain,      null: false
      t.string      :insales_password
      t.boolean     :some_option

      t.timestamps

      t.index       :insales_id
      t.index       :insales_domain
    end
  end
end
