class PagesController < ApplicationController
  def home
    @dishes = Dish.last(4)
  end
end