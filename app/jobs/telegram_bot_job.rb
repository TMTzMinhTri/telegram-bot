class TelegramBotJob < ApplicationJob
  queue_as :telegram_bot


  def perform(bot_name, *args)
    bot = Telegram.bots[bot_name.to_sym]
    bot.async(false) { bot.request(*args) }
  end
end
