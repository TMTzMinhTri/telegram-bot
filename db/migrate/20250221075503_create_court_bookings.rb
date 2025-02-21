class CreateCourtBookings < ActiveRecord::Migration[7.2]
  def change
    create_table :court_bookings, id: :uuid do |t|
      t.date :played_on, null: false
      t.tsrange :duration
      t.integer :court_fee, null: false
      t.timestamps
    end
  end
end
