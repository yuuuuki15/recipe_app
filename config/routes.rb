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
    resources :menus, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
    collection do
      get 'search'
    end
  end
  resources :users, only: [:show]
  resources :lists, only: [:index, :destroy]
  get 'lists/edit', to: 'lists#edit'
  patch 'lists/update', to: 'lists#update'
  patch 'lists/:id/check', to: 'lists#check', as: 'check'
  post '/lists', to: 'lists#create', as: 'create_list'
  resources :favorites, only: [:index, :create, :destroy]

  post '/guests/guest_sign_in', to: 'guests#new_guest'
end
