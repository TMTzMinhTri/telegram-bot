class CreateCourtBookings < ActiveRecord::Migration[7.2]
  def change
    create_table :court_bookings, id: :uuid do |t|
      t.string :booking_time
      t.decimal :hourly_rate, precision: 10, scale: 2, null: false
      t.integer :duration
      t.timestamps
    end
  end
end
