class ReportsController < ApplicationController
  include CalculatorStocks
  before_action :get_period, only:[:order_products, :send_order_products]

  def order_products
    get_order_products
  end

  def send_order_products
    get_order_products
    google_sheets_service
    # google_script_service
    # @google_scripts.script

    @google_sheets.update(@products, @period)
    redirect_to reports_success_path
  end

  def success
    @spreadsheet_id = ENV['SHEETS_PRODUCT_ID']
  end

  private
  def get_period
    @period = Period.find(params.fetch(:period_id))
  end


  def google_sheets_service
    @google_sheets = GoogleServiceSheets.new(current_user, ENV['SHEETS_PRODUCT_ID'])
  end

  def google_script_service
    @google_scripts = GoogleServiceScript.new(current_user, ENV['SHEETS_PRODUCT_ID'])
  end
end
