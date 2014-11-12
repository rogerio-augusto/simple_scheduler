class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.references :user, index: true
      t.references :room, index: true
      t.datetime :date_and_time

      t.timestamps
    end
  end
end
