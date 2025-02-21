# == Schema Information
#
# Table name: court_booking_players
#
#  id               :bigint           not null, primary key
#  amount_due       :decimal(10, 2)
#  hours_played     :integer          not null
#  name             :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  court_booking_id :uuid             not null
#  invited_by_id    :bigint
#  player_id        :bigint
#
# Indexes
#
#  index_court_booking_players_on_court_booking_id  (court_booking_id)
#  index_court_booking_players_on_invited_by_id     (invited_by_id)
#  index_court_booking_players_on_player_id         (player_id)
#
# Foreign Keys
#
#  fk_rails_...  (court_booking_id => court_bookings.id)
#  fk_rails_...  (invited_by_id => players.id)
#  fk_rails_...  (player_id => players.id)
#
class CourtBookingPlayer < ApplicationRecord
  belongs_to :player
  belongs_to :court_booking
  belongs_to :invited_by, class_name: "Player", optional: true

  before_save :set_default_hours_played

  private

  def set_default_hours_played
    return if hours_played

    range = court_booking.duration
    self.hours_played = (range.end - range.begin).to_i
  end
end
