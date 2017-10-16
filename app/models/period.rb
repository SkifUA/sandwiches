class Period < ApplicationRecord
  include ValidatorPeriods
  has_many :order
  has_many :purchases

  validates :days, presence: true, numericality: true
  validates_presence_of :start_date, :finish_date

  validates_with OrderPeriodDate
  validates_with MaximumFinishDate

  def name
    "#{start_date.strftime("%d/%m/%Y")} - #{finish_date.strftime("%d/%m/%Y")}"
  end

end
