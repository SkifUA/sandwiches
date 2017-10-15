class IngredientsController < ApplicationController
  before_action :set_ingredient, only: [:show, :edit, :update, :destroy]
  before_action :get_dish

  # GET /ingredients
  def index
    @ingredients = Ingredient.where(dish_id: @dish.id)
  end

  # GET /ingredients/1
  def show
  end

  # GET /ingredients/new
  def new
    @ingredient = Ingredient.new
  end

  # GET /ingredients/1/edit
  def edit
  end

  # POST /ingredients
  def create
    @ingredient = Ingredient.new(ingredient_params)

    if @ingredient.save
      redirect_to dish_ingredients_path(@dish), notice: 'Ingredient was successfully created.'
    else
      redirect_to new_dish_ingredient_path(@dish), notice: "Ingredient didn't add"
    end
  end

  # PATCH/PUT /ingredients/1
  def update
    if @ingredient.update(ingredient_params)
      redirect_to dish_ingredients_path(@dish), notice: 'Ingredient was successfully updated.'
    else
      redirect_to edit_dish_ingredient_path(@dish, @ingredient)
    end
  end

  # DELETE /ingredients/1
  def destroy
    @ingredient.destroy
    redirect_to dish_ingredients_path(@dish), notice: 'Ingredient was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ingredient
      @ingredient = Ingredient.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ingredient_params
      params.require(:ingredient).permit(:dish_id, :product_id, :quantity)
    end

    def get_dish
      @dish = Dish.find(params.fetch(:dish_id))
    end
end
