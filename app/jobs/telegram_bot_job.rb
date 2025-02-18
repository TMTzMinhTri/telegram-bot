class TelegramBotJob < ApplicationJob
  queue_as :telegram_bot

  def perform(bot_name, *)
    bot = Telegram.bots[bot_name.to_sym]
    bot.async(false) { bot.request(*) }
  end
end
