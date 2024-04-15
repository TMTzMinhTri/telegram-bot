max_threads_count = ENV.fetch('RAILS_MAX_THREADS', 5)
min_threads_count = ENV.fetch('RAILS_MIN_THREADS') { max_threads_count }
threads min_threads_count, max_threads_count

if ENV['RAILS_ENV'] == 'production'
  require 'concurrent-ruby'
  worker_count = Integer(ENV.fetch('WEB_CONCURRENCY') { Concurrent.physical_processor_count })
  workers worker_count if worker_count > 1
end

worker_timeout 3600 if ENV.fetch('RAILS_ENV', 'development') == 'development'

port ENV.fetch('PORT', 3000)

environment ENV.fetch('RAILS_ENV') { 'development' }

pidfile ENV.fetch('PIDFILE') { 'tmp/pids/server.pid' }

plugin :tmp_restart

if Rails.env.development?
  begin
    options = {
      config: Rails.root.join('config/ngrok.yml'),
      addr: ENV.fetch('PORT', 3000),
      inspect: true,
      log: 'log/ngrok.log',
      ngrok_url_https: 'https://pro-virtually-maggot.ngrok-free.app',
      label: 'edge=edghts_2ezJgUUaCdYAByWuo4aGpq7zXa4'
    }
    Ngrok::Tunnel.start(options)
    box = TTY::Box.frame(width: 50, height: 10, padding: 2, title: { top_left: '<NGROK>', bottom_right: '</NGROK>' },
                         style: { fg: :green, bg: :black, border: { fg: :green, bg: :black } }) do
      "STATUS: #{Ngrok::Tunnel.status}\nPORT:  #{Ngrok::Tunnel.ngrok_url_https}\n"
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
