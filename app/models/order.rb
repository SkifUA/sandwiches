class Order < ApplicationRecord
  belongs_to :user
  belongs_to :dish
  belongs_to :period


end
