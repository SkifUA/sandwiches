class Recipe < ApplicationRecord
  belongs_to :dish
  belongs_to :product

  validates_uniqueness_of :dish_id, scope: :product_id, message: I18n.t('recipes.validates.unique')

end
