Rails.application.routes.draw do
  resources :products

  resources :dishes do
    resources :recipes
  end
  devise_for :users
  root 'dishes#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
