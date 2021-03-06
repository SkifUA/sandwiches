class PurchasesController < ApplicationController
  load_and_authorize_resource

  before_action :set_purchase, only: [:show, :edit, :update, :destroy]
  before_action :get_period

  # GET /purchases
  def index
    @purchases = Purchase.where(period_id: params.fetch(:period_id)).includes(:product, :user)
  end

  # GET /purchases/1
  def show
  end

  # GET /purchases/new
  def new
    @purchase = Purchase.new
  end

  # GET /purchases/1/edit
  def edit
  end

  # POST /purchases
  def create
    @purchase = Purchase.new(purchase_params)

    if @purchase.save
      redirect_to period_purchases_path(@period), notice: 'Purchase was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /purchases/1
  def update
    if @purchase.update(purchase_params)
      redirect_to period_purchases_path(@period), notice: 'Purchase was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /purchases/1
  def destroy
    @purchase.destroy
    redirect_to period_purchases_path(@period), notice: 'Purchase was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_purchase
      @purchase = Purchase.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def purchase_params
      params.require(:purchase).permit(:user_id,
                                       :product_id,
                                       :period_id,
                                       :date_purchase,
                                       :bought,
                                       :cost_float,
                                       :description)
    end

    def get_period
      @period = Period.find(params.fetch(:period_id))
    end

end
