Rails.application.routes.draw do
  root "static_pages#home"
  devise_for :users

  resources :poker_sessions
  resources :statistics, only: [:index]
  resources :tags, only: [:index]
end
