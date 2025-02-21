# == Schema Information
#
# Table name: court_bookings
#
#  id         :uuid             not null, primary key
#  court_fee  :integer          not null
#  duration   :tsrange
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class CourtBooking < ApplicationRecord
  has_many :court_booking_players, dependent: :destroy
  has_many :players, through: :court_booking_players
  accepts_nested_attributes_for :court_booking_players, allow_destroy: true
end
