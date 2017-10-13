class Product < ApplicationRecord
  has_many :ingredients, dependent: :destroy
  has_many :dishes, through: :ingredients
  has_many :purchases

  before_create :default_percent_of_recycling
  enum measuring: { weight: 1, piece: 2 }

  validates_presence_of :name, :measuring

  def unit
    if measuring == 'weight'
      I18n.t('products.measuring.weight')
    else
      I18n.t('products.measuring.piece')
    end
  end

  def name_with_unit
    "#{name}, #{unit}"
  end

  def default_percent_of_recycling
    self.percent_of_recycling = percent_of_recycling || 0
  end
end
