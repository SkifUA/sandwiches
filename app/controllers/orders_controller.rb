class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  before_action :get_period

  # GET /orders
  def index
    @orders = Order.all
  end

  # GET /orders/1
  def show
  end

  # GET /orders/new
  def new
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  def create
    @order = Order.new(order_params)

    if @order.save
      redirect_to period_order_path(@period, @order), notice: t('orders.msg.success.create')
    else
      redirect_to new_period_order_path(@period), notice: t('orders.msg.error.create')
    end

  end

  # PATCH/PUT /orders/1
  def update
    if @order.update(order_params)
      redirect_to period_orders_path(@period), notice: t('orders.msg.success.update')
    else
      redirect_to edit_period_order_path(@period, @order), notice: t('orders.msg.error.update')
    end
  end

  # DELETE /orders/1
  def destroy
    if @order.destroy
      redirect_to period_orders_path(@period), notice: t('orders.msg.success.destroy')
    else
      redirect_to period_orders_path(@period), notice: t('orders.msg.error.destroy')
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:period_id, :dish_id, :user_id, :quantity)
    end

    def get_period
      @period = Period.find(params.fetch(:period_id))
    end
end
