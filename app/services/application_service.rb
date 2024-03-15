# frozen_string_literal: true

class ApplicationService
  def initialize(*)end
  class << self
    def call(**args)
      new(**args).call
    end
  end
end
