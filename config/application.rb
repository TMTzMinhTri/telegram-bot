# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'
require 'apartment/custom_console'
# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Bot3
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.1

    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    # config.autoload_lib(ignore: %w[assets tasks])
    config.autoload_paths += %W[#{root}/lib]
    config.active_job.queue_adapter = :sidekiq
    config.session_store :redis_store,
                         servers: ['redis://localhost:6379/2/session'],
                         expire_after: 90.minutes,
                         key: 'access_token_ne',
                         #  threadsafe: true,
                         domain: :all,
                         secure: Rails.env.production?

    config.cache_store = :redis_cache_store, {
      url: 'redis://localhost:6379/0',
      expires_in: 90.minutes,
      namespace: 'bot3_cache'
    }
    config.active_record.schema_format = :sql

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
