class TelegramBotJob < ApplicationJob
  queue_as :telegram_bot
  sidekiq_options retry: 0

  def perform(bot_name, *)
    bot = Telegram.bots[bot_name.to_sym]
    bot.async(false) { bot.request(*) }
  end
end
