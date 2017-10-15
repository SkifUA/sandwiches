module CalculatorStocks
  extend ActiveSupport::Concern

  def get_order_products
    @orders = Order.for_user_by_period(params.fetch(:user_id), params.fetch(:period_id))
    @user_name = User.find(params.fetch(:user_id)).name
    @stocks = Purchase.where(user_id: params.fetch(:user_id)).activated
    @products = order_with_stock(@orders, @stocks)
  end

  def products_by_orders(orders)
    products = {}
    orders.each do |order|
      order.dish.ingredients.each do |ingredient|
        if products[ingredient.product_id.to_s].nil?
          products[ingredient.product_id.to_s] = (ingredient.quantity * order.quantity * percent_of_recycling(ingredient) * @period.days).to_i
        else
          products[ingredient.product_id.to_s] += (ingredient.quantity * order.quantity * percent_of_recycling(ingredient) * @period.days).to_i
        end
      end
    end
    products
  end

  def order_with_stock(orders, stocks)
    products = products_by_orders(orders)

    stocks.each do |purchase|
      if products[purchase.product_id.to_s].present?
        products[purchase.product_id.to_s] -= (purchase.stock_left * percent_of_recycling(purchase)).to_i
      end
    end
    order_products_for_send products
  end

  def percent_of_recycling(object)
    (100 + object.product.percent_of_recycling) / 100.00
  end

  def order_products_for_send(products)
    return [] unless products

    products.map do |key, value|
      product = Product.find(key)
      OpenStruct.new(name: product.name_with_unit, quantity: value)
    end
  end
end