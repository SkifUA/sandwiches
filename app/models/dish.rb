class Dish < ApplicationRecord
  has_many :ingredients, dependent: :destroy
  has_many :products, through: :ingredients
  has_many :orders

  mount_uploader :image, DishUploader
end
