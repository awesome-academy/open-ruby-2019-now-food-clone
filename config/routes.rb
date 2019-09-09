Rails.application.routes.draw do
  root to: "home_pages#index"

  devise_for :users, controllers: {omniauth_callbacks: "users/omniauth_callbacks"}

  scope module: "admin", path: "admin", as: "admin" do
    get "/home", to: "homes#index"
    get "/new_user", to: "users#new_user"
    get "/edit_user", to: "users#edit_user"
    get "/show_user", to: "users#show_user"

    resources :users
  end

  scope module: "manager", path: "manager", as: "manager" do
    get "/home", to: "homes#index"

    resources :combos
    resources :comments, only: [:create, :destroy]
    resources :stores
    resources :products
    resources :bills
    resources :districts, only: [:index]
  end
end
