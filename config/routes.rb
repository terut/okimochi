Rails.application.routes.draw do
  root 'boards#home'
  get '/signup', to: 'users#new'
  get '/login', to: 'sessions#new'
  get '/logout', to: 'sessions#destroy'
  get '/auth/magic/callback', to: 'sessions#validate'

  resources :sessions, only: [:create]
  resources :users, only: [:create, :show]
  resources :boards, only: [:index]
  resources :articles, only: [:create, :update]
end
