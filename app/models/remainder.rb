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

  def old_current_to_off
    Remainder.current_remainder(period_id, product_id, user_id)
             .currents_true
             .current_to_off
  end
end
