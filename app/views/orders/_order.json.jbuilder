json.extract! order, :id, :period_id, :dish_id, :user_id, :quantity, :created_at, :updated_at
json.url order_url(order, format: :json)
