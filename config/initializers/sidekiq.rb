# frozen_string_literal: true

Sidekiq.configure_server do |config|
  config.logger = Sidekiq::Logger.new($stdout)
  config.redis = { url: "redis://localhost:6379/1" }
end

Sidekiq.configure_client do |config|
  config.redis = { url: "redis://localhost:6379/1" }
end
