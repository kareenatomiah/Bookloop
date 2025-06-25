Rails.application.routes.draw do
  get 'friends/index'
  devise_for :users, controllers: { registrations: 'users/registrations' }

  root to: 'pages#splash'
  get 'splash', to: 'pages#splash'
  get 'dashboard', to: 'dashboard#index'
  get 'up', to: 'rails/health#show', as: :rails_health_check
  get '/feed', to: 'feed#index', as: :feed
  get '/profile', to: 'users#show', as: :profile
  get '/mybooks', to: 'libraries#index', as: :mybooks
  get '/search_friends', to: 'friends#search', as: :search_friends
  get 'wishlist', to: 'wishlists#index', as: :wishlist
  get 'myfriends', to: 'friends#index', as: :myfriends

  resources :mybooks, controller: 'libraries', only: [:index, :create, :destroy]
  resources :wishlists, only: [:index, :create, :destroy]

  resources :books, only: [:index, :show]
  resources :reviews, only: [:new, :create, :edit, :update, :destroy]
  resources :categories, only: [:index, :show]
  resources :libraries, only: [:index, :create, :destroy]
  resources :users, only: [:show]
  resources :friendships, only: [:create, :destroy]

  resources :be_reads do
    member do
      get :confirm_post
      post :post_to_feed
    end

    resource :like, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
  end


  resources :friends, only: [:index, :create, :destroy] do
    collection do
      get 'search'
    end
  end
end
