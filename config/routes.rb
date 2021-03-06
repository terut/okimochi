Rails.application.routes.draw do
  root 'boards#home'
  get '/signup', to: 'users#new'
  get '/login', to: 'sessions#new'
  get '/logout', to: 'sessions#destroy'
  get '/auth/magic/callback', to: 'sessions#auth'
  get '/settings', to: 'users#edit'
  patch '/settings', to: 'users#update'
  get '/user', to: 'users#current'
  get '/article', to: 'articles#today'

  resources :sessions, only: [:create]
  resources :users, only: [:show, :create]
  resources :boards, only: [:index]
  resources :articles, only: [:create, :update]
end
