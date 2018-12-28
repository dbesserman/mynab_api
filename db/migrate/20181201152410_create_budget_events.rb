class CreateBudgetEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :budget_events do |t|
      t.string :event_type
      t.integer :month_index, :year, :variation, :category_id

      t.timestamps
    end
  end
end
