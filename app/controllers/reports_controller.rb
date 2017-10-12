class ReportsController < ApplicationController
  before_action :get_period
  def order_products
    @orders = Order.for_user_by_period(params.fetch(:user_id), params.fetch(:period_id))
    @user_name = User.find(params.fetch(:user_id)).name
    @products = Order.products_by_orders(@orders)
  end

  def send_order_products
  end

  private
  def get_period
    @period = Period.find(params.fetch(:period_id))
  end
end
