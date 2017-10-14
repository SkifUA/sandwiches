class DishesController < ApplicationController
  load_and_authorize_resource
  before_action :set_dish, only: [:show, :edit, :update, :destroy]

  # GET /dishes
  def index
    @dishes = Dish.all
  end

  # GET /dishes/1
  def show
  end

  # GET /dishes/new
  def new
    @dish = Dish.new
  end

  # GET /dishes/1/edit
  def edit
  end

  # POST /dishes
  def create
    @dish = Dish.new(dish_params)

    if @dish.save
      redirect_to @dish, notice: 'Dish was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /dishes/1
  def update
    if @dish.update(dish_params)
      redirect_to @dish, notice: 'Dish was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /dishes/1
  def destroy
    @dish.destroy
    redirect_to dishes_url, notice: 'Dish was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dish
      @dish = Dish.includes(:ingredients).find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def dish_params
      params.require(:dish).permit(:name, :description, :price, :image)
    end
end
