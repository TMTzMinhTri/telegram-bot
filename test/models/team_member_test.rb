# == Schema Information
#
# Table name: team_members
#
#  id                     :integer          not null, primary key
#  invitation_accepted_at :datetime
#  invitation_sent_at     :datetime
#  invitation_token       :string
#  status                 :integer          default(0), not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  invited_by_id          :integer
#  team_id                :integer
#  user_id                :integer
#
# Indexes
#
#  index_team_members_on_invitation_token  (invitation_token) UNIQUE
#  index_team_members_on_team_id           (team_id)
#  index_team_members_on_user_id           (user_id)
#
require "test_helper"

class TeamMemberTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
