class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :name
      t.boolean :boiling, default: false
      t.integer :percent_of_recycling
      t.integer :measuring, limit: 1

      t.timestamps
    end
  end
end
