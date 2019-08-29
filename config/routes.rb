Rails.application.routes.draw do
  root to: "home_pages#index"

  devise_for :users, controllers: {omniauth_callbacks: "users/omniauth_callbacks"}

  scope module: "admin", path: "admin", as: "admin" do
    get "/home", to: "homes#index"

    resources :users
  end
end
