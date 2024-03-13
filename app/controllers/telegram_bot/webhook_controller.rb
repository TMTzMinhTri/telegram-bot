# frozen_string_literal: true

module TelegramBot
  class WebhookController < Telegram::Bot::UpdatesController
    def start!(*)
      respond_with :message, text: t('.hi')
     end

    def read!(*)
      respond_with :message, text: t('.hi')
    end
  end
end
