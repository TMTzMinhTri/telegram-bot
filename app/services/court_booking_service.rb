class CourtBookingService
  def initialize(player_ids:, start_time:, end_time:, hourly_rate:)
    @player_ids = player_ids
    @start_time = start_time
    @end_time = end_time
    @hourly_rate = hourly_rate
  end
end
