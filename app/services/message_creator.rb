# frozen_string_literal: true

class MessageCreator < ApplicationService
  def initialize(message)
    super
    @message = message
  end

  def call; end
end
