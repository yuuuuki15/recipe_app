Rails.application.routes.draw do
  get 'users/show'
  devise_for :users
  root 'recipes#index'
  resources :recipes do
    resources :menus, only: [:create]
    resources :comments, only: [:create, :destroy]
  end
  resources :users, only: [:show]
  resources :lists, only: [:index, :edit, :destroy]
  post '/lists', to: 'lists#create', as: 'create_list'
  resources :favorites, only: [:create]
end
