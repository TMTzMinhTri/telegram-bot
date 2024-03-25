# == Schema Information
#
# Table name: teams
#
#  id         :integer          not null, primary key
#  created_by :integer
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_teams_on_created_by  (created_by)
#
require 'test_helper'

class TeamTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
