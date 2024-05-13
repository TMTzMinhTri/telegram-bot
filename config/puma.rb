# frozen_string_literal: true

# This configuration file will be evaluated by Puma. The top-level methods that
# are invoked here are part of Puma's configuration DSL. For more information
# about methods provided by the DSL, see https://puma.io/puma/Puma/DSL.html.

# Puma can serve each request in a thread from an internal thread pool.
# The `threads` method setting takes two numbers: a minimum and maximum.
# Any libraries that use thread pools should be configured to match
# the maximum value specified for Puma. Default is set to 5 threads for minimum
# and maximum; this matches the default thread size of Active Record.
max_threads_count = ENV.fetch('RAILS_MAX_THREADS', 5)
min_threads_count = ENV.fetch('RAILS_MIN_THREADS') { max_threads_count }
threads min_threads_count, max_threads_count

# Specifies that the worker count should equal the number of processors in production.
if ENV['RAILS_ENV'] == 'production'
  require 'concurrent-ruby'
  worker_count = Integer(ENV.fetch('WEB_CONCURRENCY') { Concurrent.physical_processor_count })
  workers worker_count if worker_count > 1
end

# Specifies the `worker_timeout` threshold that Puma will use to wait before
# terminating a worker in development environments.
worker_timeout 3600 if ENV.fetch('RAILS_ENV', 'development') == 'development'

# Specifies the `port` that Puma will listen on to receive requests; default is 3000.
port ENV.fetch('PORT', 3000)

# Specifies the `environment` that Puma will run in.
environment ENV.fetch('RAILS_ENV', 'development')

# Specifies the `pidfile` that Puma will use.
pidfile ENV.fetch('PIDFILE', 'tmp/pids/server.pid')

# Allow puma to be restarted by `bin/rails restart` command.
plugin :tmp_restart

if Rails.env.development?
  begin
    require 'ngrok/tunnel'
    options = {
      addr: ENV.fetch('PORT', 3000),
      inspect: true,
      log: 'log/ngrok.log',
      config: Rails.root.join('config/ngrok.yml')
    }
    Ngrok::Tunnel.start(options)
    box = TTY::Box.frame(width: 50, height: 10, padding: 2, title: { top_left: '<NGROK>', bottom_right: '</NGROK>' },
                         style: { fg: :green, bg: :black, border: { fg: :green, bg: :black } }) do
      "STATUS: #{Ngrok::Tunnel.status}\nPORT:   #{Ngrok::Tunnel.port}\nHTTP:   #{Ngrok::Tunnel.ngrok_url}\nHTTPS:  #{Ngrok::Tunnel.ngrok_url_https}\n"
    end
  rescue StandardError => e
    Rails.logger.error(e)
    box = TTY::Box.frame(width: 50, height: 5, align: :center, padding: 1,
                         title: { top_left: '<NGROK>', bottom_right: '</NGROK>' }, style: { fg: :red, bg: :black, border: { fg: :red, bg: :black } }) do
      "I couldn't create the tunnel ;("
    end
  end
  Rails.logger.debug { "\n#{box}\n" }
end

on_booted do
  if Rails.env.development? && Ngrok::Tunnel.running?
    url = Ngrok::Tunnel.ngrok_url_https
    default_url_options = {
      host: url
    }
    Rails.application.routes.default_url_options = default_url_options
    Telegram::Bot::Tasks.set_webhook
  end
end
