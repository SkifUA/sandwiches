class RemaindersController < ApplicationController
  before_action :set_remainder, only: [:show, :edit, :update, :destroy]
  before_action :get_period

  # GET period/1/remainders
  def index
    @remainders = Remainder.where(period_id: @period.id)
    @remainders = @remainders.where(user_id: current_user.id) unless current_user.admin?
  end

  # GET period/1/remainders/1
  def show
  end

  # GET period/1/remainders/new
  def new
    @remainder = Remainder.new
  end

  # GET period/1/remainders/1/edit
  def edit
  end

  # POST period/1/remainders
  def create
    @remainder = Remainder.new(remainder_params)

    if @remainder.save
      redirect_to period_remainders_path(@period), notice: t('remainders.msg.success.create')
    else
      redirect_to new_period_remainder_path(@period), notice: t('remainders.msg.error.create')
    end
  end

  # PATCH/PUT period/1/remainders/1
  def update
    if @remainder.update(remainder_params)
      redirect_to period_remainder_path(@period, @remainder), notice: t('remainders.msg.success.update')
    else
      redirect_to edit_period_remainder_path(@period, @remainder), notice: t('remainders.msg.error.update')
    end
  end

  # DELETE period/1/remainders/1
  def destroy
    @remainder.destroy
    redirect_to period_remainders_path(@period), notice: 'Remainder was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_remainder
      @remainder = Remainder.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def remainder_params
      params.require(:remainder).permit(:user_id,
                                       :product_id,
                                       :period_id,
                                       :checking_date,
                                       :left,
                                       :left_finished,
                                       :description)
    end

    def get_period
      @period = Period.find(params.fetch(:period_id))
    end
end
