Rails.application.routes.draw do
  root to: "home_pages#index"

  devise_for :users
end
