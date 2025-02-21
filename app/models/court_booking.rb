# == Schema Information
#
# Table name: court_bookings
#
#  id         :uuid             not null, primary key
#  court_fee  :integer          not null
#  duration   :tsrange
#  played_on  :date             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class CourtBooking < ApplicationRecord
  validates :played_on, presence: true

  has_many :court_booking_players, dependent: :destroy
  has_many :players, through: :court_booking_players
  accepts_nested_attributes_for :court_booking_players, allow_destroy: true

  before_save :set_played_on

  scope :this_month, -> { where(played_on: Date.current.all_month) }
  scope :filter_by_date, lambda { |range|
    where(played_on: range[:start_date]..range[:end_date]) if range[:start_date].present? && range[:end_date].present?
  }

  private

  def set_played_on
    self.played_on = start_at.to_date if start_at.present?
  end
end
