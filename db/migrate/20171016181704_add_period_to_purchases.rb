class AddPeriodToPurchases < ActiveRecord::Migration[5.1]
  def change
    add_reference :purchases, :period, index: true
  end
end
