class Purchase < ApplicationRecord
  belongs_to :user
  belongs_to :product
  belongs_to :period

  attr_accessor :cost_float

  before_create :deactivate_old
  before_save :to_cost
  after_initialize :to_cost_float

  validates_presence_of :user_id, :product_id, :date_purchase, :period_id

  scope :activated, -> () { where(active: true) }
  scope :other_period, -> (period_id) { where.not(period_id: period_id) }
  scope :current_product, -> (product_id, user_id) { where(product_id: product_id, user_id: user_id ) }
  scope :deactivate, -> () { update(active: false) }

  def set_left
    old_purchase = Purchase.activated.current_product(product_id).last
    if old_purchase
      self.left = old_purchase.left
      self.left_finished = old_purchase.left_finished
    end
  end

  def stock_left
    return nil unless active?
    stock = (bought + left) * (100 - product.percent_of_recycling) / 100
    stock += left_finished if product.boiling?
    stock
  end

  private

  def to_cost_float
    self.cost_float = (cost / 100.00).round(2) if cost.present?
  end

  def to_cost
    self.cost = (cost_float.to_f * 100).round
  end

  def deactivate_old
    Purchase.activated.other_period(period_id).current_product(product_id, user_id).deactivate
  end

end
