class Ingredient < ApplicationRecord
  belongs_to :dish
  belongs_to :product

  validates :dish_id, uniqueness: { scope: :product_id }
end
