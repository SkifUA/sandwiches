class AddSpreadsheetIdToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :spreadsheet_id, :string
  end
end
