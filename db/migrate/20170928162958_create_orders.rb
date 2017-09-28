class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.integer :period_id
      t.integer :dish_id
      t.integer :user_id
      t.integer :quantity

      t.timestamps
    end
  end
end
