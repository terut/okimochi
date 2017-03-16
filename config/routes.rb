Rails.application.routes.draw do
  root 'boards#index'
  get '/signup', to: 'users#new'
  get '/login', to: 'sessions#new'
  get '/logout', to: 'sessions#destroy'
  get '/auth/magic/callback', to: 'sessions#validate'

  resources :sessions, only: [:create]
  resources :users, only: [:create]

  namespace :api do
    resources :boards, only: [:index]
    resources :users, only: [:show]
  end
end
