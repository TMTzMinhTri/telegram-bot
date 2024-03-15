# frozen_string_literal: true

Telegram.bots_config = {
  default: {
    username: Rails.application.credentials.dig(:telegram, :bot, :username),
    token: Rails.application.credentials.dig(:telegram, :bot, :token),
    async: true
  }
}
