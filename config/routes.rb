Rails.application.routes.draw do
  root to: "home_pages#index"

  devise_for :users

  scope module: "admin" do
    get "admin/home", to: "homes#index"
  end
end
