Rails.application.routes.draw do
  get 'users/show'
  devise_for :users
  resources :users, only:[:index, :show, :edit, :update] do
    member do
      get :follows, :followers
    end
    resource :relationships, only: [:create, :destroy]
  end
  root 'recipes#index'
  resources :recipes do
    resources :menus, only: [:create]
    resources :comments, only: [:create, :destroy]
  end
  resources :users, only: [:show]
  resources :lists, only: [:index, :destroy]
  get 'lists/edit', to: 'lists#edit'
  patch 'lists/update', to: 'lists#update'
  patch 'lists/:id/check', to: 'lists#check', as: 'check'
  post '/lists', to: 'lists#create', as: 'create_list'
  resources :favorites, only: [:create, :destroy]
end
