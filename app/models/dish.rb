class Dish < ApplicationRecord
  has_many :ingredients
  has_many :products, through: :ingredients
  has_many :orders
end
