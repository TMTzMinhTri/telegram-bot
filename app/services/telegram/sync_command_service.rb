module Telegram
  class SyncCommandService
    TELEGRAM_COMMANDS_PATH = "config/telegram_commands.yml".freeze
    def initialize
      file = File.open(TELEGRAM_COMMANDS_PATH)
      @commands = YAML.load(file)
    end

    def call
      p @commands
    end
  end
end
