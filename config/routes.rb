Rails.application.routes.draw do
  get 'users/show'
  devise_for :users
  root 'recipes#index'
  resources :recipes do
    resources :menus, only: [:create]
  end
  resources :users, only: [:show]
  resources :lists, only: [:index, :new, :create]
end
