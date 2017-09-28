class Order < ApplicationRecord
  belongs_to :user
  belongs_to :dish
  belongs_to :period

  scope :for_user_by_period, -> (user_id, period_id) { where(user_id: user_id, period_id: period_id) }
end
