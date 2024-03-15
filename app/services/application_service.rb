# frozen_string_literal: true

class ApplicationService
  class << self
    def call(*args, &block)
      new(*args, &block).call
    end
  end
end
