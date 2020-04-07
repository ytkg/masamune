Rails.application.routes.draw do
  root 'home#index'
  get 'analytics/followers'
end
