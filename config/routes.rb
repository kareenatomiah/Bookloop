Rails.application.routes.draw do
  get 'categories/index'
  get 'categories/show'
  # get 'wishlists/index'
  # get 'reviews/index'
  # get 'reviews/create'
  # get 'reviews/destroy'
  # get 'bereads/index'
  # get 'bereads/create'
  # get 'bereads/destroy'
  # get 'libraries/create'
  # get 'libraries/destroy'
  # get 'categories/index'
  # get 'categories/show'
  # get 'books/index'
  # get 'books/show'
  # get 'books/create'
  # get 'books/update'
  # get 'books/destroy'
  # get 'users/index'
  # get 'users/show'
  # post 'users/create'
  # patch 'users/update'
  # delete 'users/destroy'
  get 'dashboard', to: 'dashboard#index'
  # get "books/search", to: "books#index"
  get 'splash', to: 'pages#splash'
  get "api/ratings/:work_key", to: "api/ratings#show"

  get 'wishlist', to: 'wishlists#index', as: 'wishlist'




    root to: 'pages#splash'
    devise_for :users

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  resources :books, only: [:index, :show]
  resources :reviews, only: [:new, :create, :edit, :update, :destroy]
  resources :categories, only: [:index, :show]
end
