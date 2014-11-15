class Meeting < ActiveRecord::Base
  extend SimpleCalendar
  has_calendar
  
  belongs_to :user
  belongs_to :room
  
  validates :user_id, :room_id, :starts_at, presence: true
end
