json.extract! purchase, :id, :user_id, :product_id, :date_purchase, :bought, :cost, :left, :left_finished, :created_at, :updated_at
json.url purchase_url(purchase, format: :json)
