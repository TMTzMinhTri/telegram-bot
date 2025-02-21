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
require "test_helper"

class CourtBookingTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
