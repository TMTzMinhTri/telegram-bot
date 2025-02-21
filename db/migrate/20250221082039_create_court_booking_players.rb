class CreateCourtBookingPlayers < ActiveRecord::Migration[7.2]
  def change
    create_table :court_booking_players do |t|
      t.references :court_booking, null: false, foreign_key: true, type: :uuid
      t.references :player, foreign_key: true
      t.belongs_to :invited_by, foreign_key: { to_table: :players }
      t.integer :hours_played, null: false
      t.decimal :amount_due, precision: 10, scale: 2
      t.string :name
      t.timestamps
    end
  end
end
