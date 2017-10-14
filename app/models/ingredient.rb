class Ingredient < ApplicationRecord
  belongs_to :dish
  belongs_to :product

  validates :dish_id, presence: true, uniqueness: { scope: :product_id }
  validates :quantity, presence: true, numericality: true
end
