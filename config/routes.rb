require 'sidekiq/web'
Sidekiq::Web.use ActionDispatch::Cookies
Sidekiq::Web.use Rails.application.config.session_store, Rails.application.config.session_options

Rails.application.routes.draw do
  devise_for :users

  # telegram_webhook TelegramBot::WebhookController

  authenticate :user do
    mount Sidekiq::Web => '/sidekiq'
    mount GrapeSwaggerRails::Engine => '/swagger'
  end

  mount RootApi => '/'

  get 'up' => 'rails/health#show', as: :rails_health_check

  root 'grape_swagger_rails/application#index'
end
