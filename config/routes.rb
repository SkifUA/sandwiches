Rails.application.routes.draw do

  resources :periods do
    resources :orders
  end
  resources :purchases
  resources :places
  resources :products

  resources :dishes do
    resources :ingredients
    resources :recipes
  end

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  root 'dishes#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
