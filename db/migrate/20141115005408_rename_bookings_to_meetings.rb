class RenameBookingsToMeetings < ActiveRecord::Migration
  def change
    rename_table :bookings, :meetings
  end
end
