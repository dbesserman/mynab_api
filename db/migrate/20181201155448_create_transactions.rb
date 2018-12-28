class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.string :account, :payee, :category
      t.integer :variation
      t.datetime :date_time
      t.boolean :cleared
    end
  end
end
