class CreateTeamMembers < ActiveRecord::Migration[7.1]
  def change
    create_table :team_members do |t|
      t.references :team
      t.references :user
      t.integer :status, default: 0, null: false
      t.string   :invitation_token, index: { unique: true }
      t.datetime :invitation_sent_at
      t.datetime :invitation_accepted_at
      t.integer :invited_by_id
      t.timestamps
    end
  end
end
