class Meeting < ActiveRecord::Base
  extend SimpleCalendar
  has_calendar
  
  belongs_to :user
  delegate :name, to: :user, prefix: true, allow_nil: true
  
  validates :user_id, :starts_at, presence: true
end
