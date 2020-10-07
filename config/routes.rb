Rails.application.routes.draw do
  get '/auth/:provider/callback', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  get '/login', to: 'sessions#login'
  root 'home#index'
  get 'analytics/followers'
  resources :admin_users, only: [:index]
  resources :reports, only: [:index]
  resources :tweets, only: [:index, :new, :create]
  resources :friendships, only: [:index] do
    collection do
      get :friends
      get :followers
      get :friends_and_followers
      get :friends_except_followers
      get :followers_except_friends
      post :follow
    end
  end
  resources :points, only: [:index]
  resources :daily_mission, only: [:index]
  resources :settings, only: [:index, :create]
end
