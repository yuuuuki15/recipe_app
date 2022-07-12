Rails.application.routes.draw do
  get 'users/show'
  devise_for :users
  root 'recipes#index'
  resources :recipes
  resources :users, :only => [:show]
end
