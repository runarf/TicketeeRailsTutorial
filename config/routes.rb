Rails.application.routes.draw do
  namespace :admin do
  get 'users/index'
  end

  root "projects#index"

  resources :projects do
    resources :tickets
  end

  resources :users

  get "/signin", to: "sessions#new"
  post "/signin", to: "sessions#create"

  namespace :admin do
    resources :users
  end
  
end
