class CreateCourtBookingPlayers < ActiveRecord::Migration[7.2]
  def change
    create_table :court_booking_players do |t|
      t.references :court_booking, null: false, foreign_key: true
      t.references :player, foreign_key: true
      t.string :name
      t.belongs_to :invited_by, foreign_key: { to_table: :players }
      t.integer :played_minutes, null: false
      t.timestamps
    end
  end
end
