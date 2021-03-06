Rails.application.routes.draw do
  root to: 'home#index'

  resources :meals
  resources :meal_categories

  put '/add_item', to: "cart#add_item", as: 'add'
  put '/remove_item', to: "cart#remove_item", as: 'remove'
  get '/checkout', to: "home#checkout", as: 'checkout'

  resources :orders   
  resources :manage_users
  resources :order_meals   
  devise_for :users

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
