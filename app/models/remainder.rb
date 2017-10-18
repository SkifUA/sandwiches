class Remainder < ApplicationRecord
  belongs_to :period
  belongs_to :product
  belongs_to :user

  before_create :old_current_to_off

  validates_presence_of :user_id, :product_id, :checking_date, :period_id
  validates :left, presence: true, numericality: true
  validates :left_finished, numericality: true


  scope :currents_true, -> () { where(current: true) }
  scope :current_remainder, -> (period_id, product_id, user_id) { where(period_id: period_id, product_id: product_id, user_id: user_id ) }
  scope :current_to_off, -> () { update(current: false) }
  scope :for_the_period, -> (user_id, period_id) { where(user_id: user_id, period_id: (period_id.to_i - 1)) }

  def old_current_to_off
    Remainder.current_remainder(period_id, product_id, user_id)
             .currents_true
             .current_to_off
  end

  def left_for_finished
    return nil unless current?
    stock = left * (100 - product.percent_of_recycling) / 100
    stock += left_finished if product.boiling?
    stock
  end
end
