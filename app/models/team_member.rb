# == Schema Information
#
# Table name: team_members
#
#  id                     :integer          not null, primary key
#  invitation_accepted_at :datetime
#  invitation_created_at  :datetime
#  invitation_limit       :integer
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
class TeamMember < ApplicationRecord
  VALID_PERIOD_DAYS = 3.days
  belongs_to :team
  belongs_to :user
  before_save :generate_invitation_token
  after_commit :send_on_create_invitation_instructions, on: :create

  class << self
    def verify_invitation_token(token)
      record = find_by(invitation_token: token)
      raise ArgumentError, 'Invite token invalid' unless record && VALID_PERIOD_DAYS.since(record.invitation_sent_at)

      record
    end
  end

  private

  def generate_invitation_token
    self.invitation_sent_at = Time.current
    self.invitation_token = Devise.friendly_token
  end

  def send_on_create_invitation_instructions
    TeamMailer.with(member: self)
              .invitation_instructions
              .deliver_later
  end
end
