module CalculatorStocks
  extend ActiveSupport::Concern

  def get_order_products
    @orders = Order.for_user_by_period(params.fetch(:user_id), params.fetch(:period_id))
    @user_name = User.find(params.fetch(:user_id)).name
    @remainders = Remainder.for_the_period(params.fetch(:user_id), params.fetch(:period_id)).currents_true
    @products = products_with_remainders(@orders, @remainders)
  end

  def products_by_orders(orders)
    products = {}
    orders.each do |order|
      order.dish.ingredients.each do |ingredient|
        next unless ingredient.product.report_tab?
        if products[ingredient.product_id.to_s].nil?
          products[ingredient.product_id.to_s] = (ingredient.quantity * order.quantity * percent_of_recycling(ingredient) * @period.days).to_i
        else
          products[ingredient.product_id.to_s] += (ingredient.quantity * order.quantity * percent_of_recycling(ingredient) * @period.days).to_i
        end
      end
    end
    products
  end

  def products_with_remainders(orders, remainders)
    products = products_by_orders(orders)

    remainders.each do |remainder|
      next if products[remainder.product_id.to_s].blank?
      if remainder.product.boiling?
        products[remainder.product_id.to_s] -= remainder.left_for_finished
      else
        products[remainder.product_id.to_s] -= remainder.left
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