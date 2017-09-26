class CreateRecipes < ActiveRecord::Migration[5.1]
  def change
    create_table :recipes do |t|
      t.integer :dish_id
      t.integer :product_id
      t.integer :quantity

      t.timestamps
    end
  end
end
