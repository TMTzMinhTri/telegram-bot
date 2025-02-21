# == Schema Information
#
# Table name: court_booking_players
#
#  id               :integer          not null, primary key
#  name             :string
#  played_minutes   :integer          not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  court_booking_id :integer          not null
#  invited_by_id    :integer
#  player_id        :integer
#
# Indexes
#
#  index_court_booking_players_on_court_booking_id  (court_booking_id)
#  index_court_booking_players_on_invited_by_id     (invited_by_id)
#  index_court_booking_players_on_player_id         (player_id)
#
# Foreign Keys
#
#  court_booking_id  (court_booking_id => court_bookings.id)
#  invited_by_id     (invited_by_id => players.id)
#  player_id         (player_id => players.id)
#
class CourtBookingPlayer < ApplicationRecord
  belongs_to :player
  belongs_to :court_booking, optional: true
  belongs_to :invited_by, class_name: "Player", optional: true
end
