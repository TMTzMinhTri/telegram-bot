# frozen_string_literal: true

class MessageCreator < ApplicationService
  attr_reader :bet_types, :vendors

  def initialize(body:)
    @bet_types = parse_yaml('config/betting_types.yml')
    @vendors = parse_yaml('config/vendors.yml')
    @body = body
    super
  end

  def call
    # @body
    # @bet_types.keys
    parse_body(@body)
  end

  private

  def parse_body(string)
    pattern = /\b(?<channel>#{vendors.values.join('|')})\b\s(?<amount>\d+)\s(?<kind>#{bet_types.values.join('|')})\s(?<value>\d+)/
    p pattern
    match_data = string.match(pattern)
    return unless match_data

    p match_data
    {
      channel: vendors[match_data[:channel]],
      amount: match_data[:amount].to_i,
      kind: bet_types[match_data[:kind]],
      value: match_data[:value].to_i
    }
  end
end
