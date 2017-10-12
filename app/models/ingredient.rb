class Ingredient < ApplicationRecord
  belongs_to :dish
  belongs_to :product

end
