module Telegram
  class SyncCommandService < ApplicationService
    TELEGRAM_COMMANDS_PATH = "config/telegram_commands.yml".freeze
    def initialize
      super
      file = File.open(TELEGRAM_COMMANDS_PATH)
      @commands = YAML.load(file)
    end

    def call
      telegram_bot.set_my_commands(
        commands: @commands,
        scope: {
          type: "all_group_chats"
        }
      )
    end
  end
end
