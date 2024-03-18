# frozen_string_literal: true

class MessageCreator < ApplicationService
  def initialize(body:)
    super
    @bet_types = parse_yaml('config/betting_types.yml')
  end

  def call
    # @body
    @bet_types
  end
end
