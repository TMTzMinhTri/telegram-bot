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
require "test_helper"

class CourtBookingTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
