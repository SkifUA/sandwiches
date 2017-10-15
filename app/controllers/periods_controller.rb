class PeriodsController < ApplicationController
  load_and_authorize_resource

  before_action :set_period, only: [:show, :edit, :update, :destroy]

  # GET /periods
  def index
    @periods = Period.all.order(finish_date: :desc)
  end

  # GET /periods/1
  def show
  end

  # GET /periods/new
  def new
    @period = Period.new
  end

  # GET /periods/1/edit
  def edit
  end

  # POST /periods
  def create
    @period = Period.new(period_params)

    if @period.save
      redirect_to @period, notice: t('periods.msg.success.create')
    else
      render :new
    end
  end

  # PATCH/PUT /periods/1
  def update
    if @period.update(period_params)
      redirect_to @period, notice: t('periods.msg.success.update')
    else
      render :edit
    end
  end

  # DELETE /periods/1
  def destroy
    @period.destroy
    redirect_to periods_url, notice: t('periods.msg.success.destroy')
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_period
      @period = Period.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def period_params
      params.require(:period).permit(:start_date, :finish_date, :days)
    end
end
