class Purchase < ApplicationRecord
  belongs_to :user
  belongs_to :product

  attr_accessor :cost_float

  before_save :to_cost
  after_initialize :to_cost_float

  def to_cost_float
    self.cost_float = (cost / 100.00).round(2) if cost.present?
  end

  def to_cost
    self.cost = (cost_float.to_f * 100).round
  end


end
