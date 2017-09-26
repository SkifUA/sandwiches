json.extract! recipe, :id, :dish_id, :product_id, :quantity, :created_at, :updated_at
json.url recipe_url(recipe, format: :json)
