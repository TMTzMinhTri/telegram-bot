class CourtBookingService < ApplicationService
  def initialize(player_ids:, start_time:, end_time:, court_fee:)
    super
    @player_ids = player_ids
    @start_time = DateTime.parse(start_time)
    @end_time =  DateTime.parse(end_time)
    @court_fee = court_fee
  end

  def call
    ActiveRecord::Base.transaction do
      players = Player.find @player_ids
      court_booking = CourtBooking.new(booking_params)
      court_booking.players << players
      court_booking.save!
    rescue ActiveRecord::RecordInvalid => e
      Rails.logger.error("Event creation failed: #{e.message}")
      nil  # Return nil if something fails
    end
  end

  private

  def booking_params
    {
      duration: @start_time.utc..@end_time.utc,
      court_fee: @court_fee
    }
  end
end
