class AddReportTabToProduct < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :report_tab, :boolean, default: true
  end
end
