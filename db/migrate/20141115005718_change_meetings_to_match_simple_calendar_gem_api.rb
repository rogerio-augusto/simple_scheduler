class ChangeMeetingsToMatchSimpleCalendarGemApi < ActiveRecord::Migration
  def change
    rename_column :meetings, :date_and_time, :starts_at
    add_column :meetings, :ends_at, :datetime
  end
end
