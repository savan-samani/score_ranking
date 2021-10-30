Rails.application.routes.draw do
  namespace :api do
    resources :players, only: [:show]
    resources :scores, only: [:index, :show, :create, :destroy]
  end
end
