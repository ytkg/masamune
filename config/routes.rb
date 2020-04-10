Rails.application.routes.draw do
  root 'home#index'
  get 'analytics/followers'
  resources :reports, only: [:index]
end
