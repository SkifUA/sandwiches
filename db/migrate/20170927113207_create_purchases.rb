class CreatePurchases < ActiveRecord::Migration[5.1]
  def change
    create_table :purchases do |t|
      t.integer :user_id
      t.integer :product_id
      t.date :date_purchase
      t.integer :bought
      t.integer :cost
      t.integer :left
      t.integer :left_finished
      t.text :description
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
