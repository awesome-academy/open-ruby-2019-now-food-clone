Rails.application.routes.draw do
  root to: "home_pages#index"

  devise_for :users, controllers: {omniauth_callbacks: "users/omniauth_callbacks"}

  scope module: "admin" do
    get "admin/home", to: "homes#index"
  end
end
