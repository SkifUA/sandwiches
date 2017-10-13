module CalculatorStocks
  extend ActiveSupport::Concern

  def products_by_orders(orders)
    products = {}
    orders.each do |order|
      order.dish.ingredients.each do |ingredient|
        if products[ingredient.product_id.to_s].nil?
          products[ingredient.product_id.to_s] = (ingredient.quantity * order.quantity * percent_of_recycling(ingredient)).to_i
        else
          products[ingredient.product_id.to_s] += (ingredient.quantity * order.quantity * percent_of_recycling(ingredient)).to_i
        end
      end
    end
    products
  end

  def order_with_stock(orders, stock)
    products = products_by_orders(orders)

    stock.each do |purchase|
      if products[purchase.product_id.to_s].present?
        products[purchase.product_id.to_s] -= (purchase.stock_left * percent_of_recycling(purchase)).to_i
      end
    end
    products
  end

  def percent_of_recycling(object)
    (100 + object.product.percent_of_recycling) / 100.00
  end
end