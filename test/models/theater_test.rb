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
require "test_helper"

class TheaterTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
