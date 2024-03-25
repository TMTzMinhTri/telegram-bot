class AddTeamInvitationToUser < ActiveRecord::Migration[7.1]
  def change
    add_column :team_members, :invitation_token, :string
    add_column :team_members, :invitation_created_at, :datetime
    add_column :team_members, :invitation_sent_at, :datetime
    add_column :team_members, :invitation_accepted_at, :datetime
    add_column :team_members, :invitation_limit, :integer
    add_column :team_members, :invited_by_id, :integer
    add_index :team_members, :invitation_token, unique: true
  end
end
