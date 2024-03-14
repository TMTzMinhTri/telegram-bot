# frozen_string_literal: true

module TelegramBot
  class BaseController < Telegram::Bot::UpdatesController
    include Telegram::Bot::UpdatesController::MessageContext
    class << self
      def dispatch(bot, update, request)
        WebhookController.dispatch(bot, update, request)
      end
    end
  end
end
