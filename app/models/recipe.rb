class Recipe < ApplicationRecord
  belongs_to :dish
  belongs_to :product

  validates_uniqueness_of :dish_id, scope: :product_id, message: I18n.t('recipes.validates.unique')

  scope :by_dish, -> (dish_id) { where(dish_id: dish_id) }

end
