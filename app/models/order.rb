class Order < ApplicationRecord
  belongs_to :user
  belongs_to :dish
  belongs_to :period

  validates :period_id, uniqueness: { scope: [:user_id, :dish_id] }

  scope :for_user_by_period, -> (user_id, period_id) { where(user_id: user_id, period_id: period_id) }

  def self.products_by_orders(orders)
    products = {}
    orders.each do |order|
      order.dish.ingredients.each do |ingredient|
        if products[ingredient.product_id.to_s].nil?
          products[ingredient.product_id.to_s] = ingredient.quantity * order.quantity
        else
          products[ingredient.product_id.to_s] += ingredient.quantity * order.quantity
        end
      end
    end
    products
  end
end
