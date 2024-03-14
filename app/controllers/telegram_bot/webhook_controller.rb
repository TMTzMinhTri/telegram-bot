# frozen_string_literal: true

module TelegramBot
  class WebhookController < Telegram::Bot::UpdatesController # rubocop:disable Style/Documentation
    include Telegram::Bot::UpdatesController::Session
    include Telegram::Bot::UpdatesController::MessageContext

    def start!(*)
      session[:webhook] = 'endpoint'
      respond_with :message, text: t('.hi')
    end

    def read!(*)
      respond_with :message, text: session[:webhook] || 'empty'
    end

    def rename!(*)
      # set context for the next message
      save_context :rename_from_message
      respond_with :message, text: 'What name do you like?'
    end

    # register context handlers to handle this context
    def rename_from_message(*words)
      # update_name words[0]
      p words
      respond_with :message, text: 'Renamed!'
    end

    private

    def session_key
      "#{bot.username}:#{chat['id']}:#{from['id']}" if chat && from
    end
  end
end
