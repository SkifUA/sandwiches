class Place < ApplicationRecord
  belongs_to :user

  validates :name, presence: true, length: {minimum: 5, maximum: 50}, uniqueness: true
  validates :description, presence: true, length: {minimum: 5, maximum: 500}
  validates_presence_of :user_id
end
