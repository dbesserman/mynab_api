class AddCategoryIdToTransactions < ActiveRecord::Migration[5.2]
  def change
    add_column :transactions, :category_id, :integer
  end
end
