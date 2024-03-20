# frozen_string_literal: true

module Telegram
  class CommandModifier < ApplicationService
    def initialize
      @commands = parse_yaml('config/telegram_commands.yml')
      super
    end

    def call
      telegram_bot.set_my_commands(commands: @commands)
    end

    private

    def telegram_commands
      @telegram_commands ||= telegram_bot.async(false) { telegram_bot.get_my_commands }
      raise ApplicationError, 'Could not get telegram commands' if @telegram_commands['ok'] == false

      @telegram_commands['result']
    end
  end
end
