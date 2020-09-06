Rails.application.routes.draw do
  get '/auth/:provider/callback', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  get '/login', to: 'sessions#login'
  root 'home#index'
  get 'analytics/followers'
  resources :reports, only: [:index]
  resources :tweets, only: [:index]
  resources :friendships, only: [:index]
end
