Rails.application.routes.draw do
  get '/auth/:provider/callback', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  root 'home#index'
  get 'analytics/followers'
  resources :reports, only: [:index]
  resources :tweets, only: [:index]
  resources :users, only: [:index]
  resources :friendships, only: [:index]
end
