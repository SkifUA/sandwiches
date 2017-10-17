class CreateRemainders < ActiveRecord::Migration[5.1]
  def change
    create_table :remainders do |t|
      t.belongs_to :period, index: true
      t.belongs_to :user, index: true
      t.belongs_to :product, index: true
      t.integer :left, default: 0
      t.integer :left_finished, default: 0
      t.text :description
      t.date :checking_date
      t.boolean :current, default: true
      t.timestamps
    end
  end
end
