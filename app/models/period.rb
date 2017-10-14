class Period < ApplicationRecord
  has_many :order

  validates :days, presence: true, numericality: true
  validates_presence_of :start_date, :finish_date
end
