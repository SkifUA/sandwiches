Rails.application.routes.draw do

  resources :periods do
    get '/for-cook/:user_id', to: 'orders#for_cook', as: 'for_cook'
    resources :orders
  end
  resources :purchases
  resources :places
  resources :products

  resources :dishes do
    resources :ingredients
  end

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  root 'dishes#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
