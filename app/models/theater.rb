# == Schema Information
#
# Table name: theaters
#
#  id                    :bigint           not null, primary key
#  name                  :string           not null
#  seating_layouts       :jsonb
#  seats_count           :integer          default(0)
#  seats_count_available :integer          default(0)
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  cinama_id             :uuid
#
# Indexes
#
#  index_theaters_on_cinama_id           (cinama_id)
#  index_theaters_on_name_and_cinama_id  (name,cinama_id) UNIQUE
#  index_theaters_on_seating_layouts     (seating_layouts) USING gin
#
class Theater < ApplicationRecord
  belongs_to :cinama, counter_cache: true

  attribute :seating_layouts, SeatingLayout.to_array_type

  validates :name, uniqueness: { scope: :cinama_id } # rubocop:disable Rails/UniqueValidationWithoutIndex
  before_save :calculate_seat_count

  private

  def calculate_seat_count
    seats = seating_layouts.flat_map { |row| row[:seats] }
                           .filter { |seat| !seat.aisle? }
    self.seats_count = seats.count
    self.seats_count_available = seats.count { |seat| seat.status == true }
  end
end
