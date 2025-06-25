Rails.application.routes.draw do
  get 'friends/index'
  # Devise routes
  devise_for :users, controllers: { registrations: 'users/registrations' }

  # Pages & general navigation
  root to: 'pages#splash'
  get 'splash', to: 'pages#splash'
  get 'dashboard', to: 'dashboard#index'
  get 'up', to: 'rails/health#show', as: :rails_health_check
  get '/feed', to: 'feed#index', as: :feed
  get '/profile', to: 'users#show', as: :profile
  get '/mybooks', to: 'books#mybooks', as: 'mybooks'
  get '/search_friends', to: 'friends#search', as: 'search_friends'


  # API
  get "api/ratings/:work_key", to: "api/ratings#show"

  # Custom named routes
  get 'wishlist', to: 'wishlists#index', as: 'wishlist'
  get 'myfriends', to: 'friends#index', as: 'myfriends'

  # Resources
  resources :books, only: [:index, :show]
  resources :reviews, only: [:new, :create, :edit, :update, :destroy]
  resources :categories, only: [:index, :show]
  resources :wishlists, only: [:index, :create]
  resources :libraries, only: [:create]
  resources :users, only: [:show]
  resources :friendships, only: [:create, :destroy]

  # BeReads with custom member routes for confirm_post and post_to_feed
  resources :be_reads do
    member do
      get :confirm_post
      post :post_to_feed
    end

    # Nested singular like resource (for create/destroy like on a BeRead)
    resource :like, only: [:create, :destroy]

    # Nested comments resource for be_reads
    resources :comments, only: [:create, :destroy]
  end


  resources :friends, only: [:index, :create, :destroy] do
    collection do
      get 'search'
    end
  end
end
