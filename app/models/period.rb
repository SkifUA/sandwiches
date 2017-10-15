class Period < ApplicationRecord
  include ValidatorPeriods
  has_many :order

  validates :days, presence: true, numericality: true
  validates_presence_of :start_date, :finish_date

  validates_with OrderPeriodDate
  validates_with MaximumFinishDate

end
