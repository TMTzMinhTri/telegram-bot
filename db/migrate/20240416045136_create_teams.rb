class CreateTeams < ActiveRecord::Migration[7.1]
  def change
    create_table :teams do |t|
      t.string :name
      t.integer :created_by, null: false
      t.timestamps
    end
    add_index :teams, :created_by
  end
end
