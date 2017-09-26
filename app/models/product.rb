class Product < ApplicationRecord
  enum measuring: { weight: 1, piece: 2 }

  validates_presence_of :name, :measuring
end
