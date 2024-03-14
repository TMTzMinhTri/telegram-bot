# frozen_string_literal: true

require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :users
  default_url_options host: 'https://9a53-2001-ee0-d744-4130-c1d9-b76a-7257-d0a8.ngrok-free.app'
  telegram_webhook TelegramBot::WebhookController
  mount Sidekiq::Web => '/sidekiq'

  root 'page#index'
  get 'page/index'
  get 'up' => 'rails/health#show', as: :rails_health_check
end
