class ApplicationService
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

  protected

  def telegram_bot
    @telegram_bot ||= Telegram.bot
  end
end
