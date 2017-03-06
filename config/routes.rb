Rails.application.routes.draw do
  root 'boards#index'
  get '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  namespace :api do
    resources :boards, only: [:index]
    resources :users, only: [:show]
  end
end
