class ApplicationService
  attr_reader :errors, :result

  def initialize(*)
    @errors = []
    @result = nil
  end

  def success?
    errors.blank?
  end
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
