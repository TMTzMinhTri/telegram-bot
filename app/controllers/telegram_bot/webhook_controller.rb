# frozen_string_literal: true

module TelegramBot
  class WebhookController < Telegram::Bot::UpdatesController # rubocop:disable Style/Documentation
    include Telegram::Bot::UpdatesController::Session
    include Telegram::Bot::UpdatesController::MessageContext
    include TelegramAuthenticatable

    class Unauthorization < StandardError; end

    rescue_from Unauthorization, with: :handle_unauthorizated

    def start!(*)
      authentication_telegram_user!
      respond_with :message, text: t('.hi')
    end

    def rename!(*)
      authentication_telegram_user!
      # set context for the next message
      save_context :rename_from_message
      respond_with :message, text: 'What name do you like?'
    end

    # register context handlers to handle this context
    def rename_from_message(*words)
      # update_name words[0]
      Rails.logger.debug words
      respond_with :message, text: 'Renamed!'
    end

    def message(*)
      respond_with :message, text: 'What do you like?'
    end

    private

    def session_key
      return unless chat && from && chat['type'] == 'private'

      "#{bot.username}:#{from['username']}:#{from['id']}"
    end

    def handle_unauthorizated
      save_context(:login)
      respond_with :message, text: t('.unauthenticated')
    end

    def authentication_telegram_user!
      raise Unauthorization if current_client.nil?
    end

    def current_client
      @current_client ||= (Client.find_by(id: session['client_id']) if session.key?(:client_id))
    end
  end
end
