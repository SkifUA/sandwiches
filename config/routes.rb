Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  get 'reports/order-products/:period_id/:user_id', to: 'reports#order_products', as: 'order_products'

  post 'reports/send-order-products/:period_id/:user_id', to: 'reports#send_order_products', as: 'send_products'
  get 'reports/success', to: 'reports#success'
  resources :periods do
    get '/for-cook/:user_id', to: 'orders#for_cook', as: 'for_cook'
    resources :orders
    resources :remainders
    resources :purchases
  end
  resources :purchases
  resources :places
  resources :products

  resources :dishes do
    resources :ingredients
  end

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  root 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
