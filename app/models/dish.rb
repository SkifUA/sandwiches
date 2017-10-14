class Dish < ApplicationRecord
  has_many :ingredients, dependent: :destroy
  has_many :products, through: :ingredients
  has_many :orders

  mount_uploader :image, DishUploader

  validates :name, presence: true, length: {minimum: 5, maximum: 50}, uniqueness: true
  validates :description, presence: true, length: {minimum: 5, maximum: 500}
  validates :price, presence: true, numericality: true
end
