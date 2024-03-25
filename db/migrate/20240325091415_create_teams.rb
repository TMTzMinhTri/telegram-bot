class CreateTeams < ActiveRecord::Migration[7.1]
  def change
    create_table :teams do |t|
      t.string :name, null: false
      t.integer :created_by, index: true
      t.timestamps
    end
  end
end
