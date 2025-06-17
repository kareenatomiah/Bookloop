Rails.application.routes.draw do
  get 'reviews/index'
  get 'reviews/create'
  get 'reviews/destroy'
  get 'bereads/index'
  get 'bereads/create'
  get 'bereads/destroy'
  get 'libraries/create'
  get 'libraries/destroy'
  get 'categories/index'
  get 'categories/show'
  get 'books/index'
  get 'books/show'
  get 'books/create'
  get 'books/update'
  get 'books/destroy'
  get 'users/index'
  get 'users/show'
  get 'users/create'
  get 'users/update'
  get 'users/destroy'
  get 'splash', to: 'pages#splash'

  devise_for :users
  root to: 'pages#splash'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
