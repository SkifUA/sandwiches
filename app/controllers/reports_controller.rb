class ReportsController < ApplicationController
  include CalculatorStocks
  before_action :get_period, only:[:order_products, :send_order_products]

  def order_products
    get_order_products
  end

  def send_order_products
    if current_user.spreadsheet_id.nil?
      redirect_back fallback_location: periods_path, notice: t('reports.msg.error.table_not_found') and return
    end
    get_order_products
    google_sheets_service
    cook = User.find(params.fetch(:user_id))
    # google_script_service
    # @google_scripts.script
    begin
      @google_sheets.update(cook,@products, @period)
    rescue
      redirect_back fallback_location: periods_path, notice: t('reports.msg.error.not_sent') and return
    end

    redirect_to report_success_path(current_user.spreadsheet_id)
  end

  def success
    @spreadsheet_id = params.fetch('spreadsheet_id')
  end

  private
  def get_period
    @period = Period.find(params.fetch(:period_id))
  end

  def google_sheets_service
    @google_sheets = GoogleServiceSheets.new(current_user, current_user.spreadsheet_id)
  end
  # TODO
  # def google_script_service
  #   @google_scripts = GoogleServiceScript.new(current_user, current_user.spreadsheet_id)
  # end
end
