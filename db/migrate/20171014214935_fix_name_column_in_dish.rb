class FixNameColumnInDish < ActiveRecord::Migration[5.1]
  def self.up
    rename_column :dishes, :prise, :price
  end

  def self.down
    rename_column :dishes, :price, :prise
  end
end
