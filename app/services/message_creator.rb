# frozen_string_literal: true

require 'yaml'

class MessageCreator < ApplicationService
  def initialize(body:)
    @bet_types = YAML.load(File.open)
    super

    # @body = body
  end

  def call
    # @body
    @bet_types
  end
end
