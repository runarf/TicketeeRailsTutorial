Rails.application.routes.draw do
  namespace :admin do
  get 'users/index'
  end

  root "projects#index"

  resources :projects do
    resources :tickets do
      collection do
        get :search
      end
    end         
  end

  resources :tickets do
    resources :comments
    resources :tags do
      member do
        delete :remove
      end
    end
  end

  resources :users

  get "/signin", to: "sessions#new"
  post "/signin", to: "sessions#create"

  namespace :admin do
    root :to => "base#index"
    resources :users do
      resources :permissions

      put "permissions", to: "permissions#set",
          as: "set_permissions"
    end
    resources :states do
      member do
        get :make_default
      end
    end
  end

  delete "/signout", to: "sessions#destroy", as: "signout"
  resources :files

  namespace :api do
    resources :tickets
  end
end
