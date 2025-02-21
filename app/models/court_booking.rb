# == Schema Information
#
# Table name: court_bookings
#
#  id           :uuid             not null, primary key
#  booking_time :string
#  duration     :integer
#  hourly_rate  :decimal(10, 2)   not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class CourtBooking < ApplicationRecord
  has_many :court_booking_players, dependent: :destroy
  has_many :players, throught: :court_booking_players, dependent: :destroy
end
