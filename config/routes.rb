Rails.application.routes.draw do
  root "static_pages#home"
  devise_for :users
  require "sidekiq/web"

  Rails.application.routes.draw do
    Sidekiq::Web.use Rack::Auth::Basic do |username, password|
      ActiveSupport::SecurityUtils.secure_compare(::Digest::SHA256.hexdigest(username), ::Digest::SHA256.hexdigest(ENV["SIDEKIQ_USERNAME"])) &
        ActiveSupport::SecurityUtils.secure_compare(::Digest::SHA256.hexdigest(password), ::Digest::SHA256.hexdigest(ENV["SIDEKIQ_PASSWORD"]))
    end
    mount Sidekiq::Web => "/sidekiq"

    resources :poker_sessions, only: [:index]
    resources :exports, only: [:create]
  end
  resources :poker_sessions
  resources :statistics, only: [:index]
  resources :tags, only: [:index]
end
