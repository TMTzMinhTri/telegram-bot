require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Saasgear
  class Application < Rails::Application
    config.load_defaults 7.1
    config.autoload_lib(ignore: %w[assets tasks])
    config.active_job.queue_adapter = :sidekiq
    config.session_store :redis_store,
                         servers: ['redis://localhost:6379/2/session'],
                         expire_after: 90.minutes,
                         key: 'access_token_ne',
                         #  threadsafe: true,
                         #  domain: :all,
                         secure: Rails.env.production?

    config.cache_store = :redis_cache_store, {
      url: 'redis://localhost:6379/0',
      expires_in: 90.minutes,
      namespace: 'bot3_cache'
    }
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
