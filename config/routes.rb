Rails.application.routes.draw do
  root 'boards#index'

  namespace :api do
    resources :boards, only: [:index]
    resources :users, only: [:show]
  end
end
