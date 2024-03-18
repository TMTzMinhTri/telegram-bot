# frozen_string_literal: true

class ApplicationService
  def initialize(*)end
  class << self
    def call(**args)
      new(**args).call
    end
  end

  def parse_yaml(file)
    YAML.load(File.open(file))
  end

  def telegram_bot
    @telegram_bot ||= Telegram.bot
  end
end
