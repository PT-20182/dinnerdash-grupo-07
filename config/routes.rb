Rails.application.routes.draw do
  root to: 'home#index'

  resources :meal_categories
  resources :orders
  
  devise_for :users

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
