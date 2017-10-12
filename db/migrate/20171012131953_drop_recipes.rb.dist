class DropRecipes < ActiveRecord::Migration[5.1]
  def up
    drop_table :recipes
  end

  def down
    create_table :recipes do |t|
      t.integer :dish_id
      t.integer :product_id
      t.integer :quantity
      t.timestamps
    end
  end
end
