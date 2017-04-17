Rails.application.routes.draw do
  root 'boards#home'
  get '/signup', to: 'users#new'
  get '/login', to: 'sessions#new'
  get '/logout', to: 'sessions#destroy'
  get '/auth/magic/callback', to: 'sessions#validate'
  get '/settings', to: 'users#edit'
  patch '/settings', to: 'users#update'

  resources :sessions, only: [:create]
  resources :users, only: [:show, :create]
  resources :boards, only: [:index]
  resources :articles, only: [:create, :update]
end
