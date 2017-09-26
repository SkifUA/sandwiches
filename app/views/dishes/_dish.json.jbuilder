json.extract! dish, :id, :name, :description, :prise, :created_at, :updated_at
json.url dish_url(dish, format: :json)
