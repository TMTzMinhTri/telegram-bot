class CreateTeamMembers < ActiveRecord::Migration[7.1]
  def change
    create_table :team_members do |t|
      t.references :team
      t.references :user
      t.integer :status, default: 0, null: false
      t.timestamps
    end
  end
end
