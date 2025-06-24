Rails.application.routes.draw do
  get 'feed/index'
  get 'categories/index'
  get 'categories/show'

  get 'dashboard', to: 'dashboard#index'
  get 'splash', to: 'pages#splash'
  get "api/ratings/:work_key", to: "api/ratings#show"
  get 'wishlist', to: 'wishlists#index', as: 'wishlist'
  get 'mybooks', to: 'libraries#index', as: 'mybooks'

  root to: 'pages#splash'

  devise_for :users, controllers: { registrations: 'users/registrations' }

  get "/profile", to: "users#show", as: :profile
  get "up", to: "rails/health#show", as: :rails_health_check
  get 'feed', to: 'feed#index', as: :feed

  resources :books, only: [:index, :show]
  resources :reviews, only: [:new, :create, :edit, :update, :destroy]
  resources :categories, only: [:index, :show]
  resources :wishlists, only: [:index, :create]
  resources :libraries, only: [:create]
  resources :users, only: [:show]
  resources :be_reads

  resources :be_reads do
    resource :like, only: [:create, :destroy]
    resources :comments, only: [:create]

    member do
      get :confirm_post
      post :post_to_feed
    end
  end
end
