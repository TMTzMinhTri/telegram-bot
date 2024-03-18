class TelegramCommandCreator < ApplicationService
  def initialize
    @commands = parse_yaml('config/telegram_commands.yml')
    super
  end

  def call
    @commands
  end

  private

  def current_commands
    telegram_commands = telegram_bot.async(false) do
      telegram_bot.get_my_commands
    end
    raise ApplicationError, 'Could not get telegram commands' if telegram_commands['ok'] == false

    telegram_commands['result']
  end
end
