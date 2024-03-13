# frozen_string_literal: true
require 'sidekiq/web'

Rails.application.routes.draw do
  default_url_options host: 'https://c6ec-2001-ee0-d744-4130-39a5-781c-592e-69f7.ngrok-free.app'
  telegram_webhook TelegramBot::BaseController
  mount Sidekiq::Web => "/sidekiq" 
  
  root 'page#index'
  get 'page/index'
  get 'up' => 'rails/health#show', as: :rails_health_check
end
