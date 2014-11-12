class Booking < ActiveRecord::Base
  belongs_to :user
  belongs_to :room
  
  validates :user_id, :room_id, :date_and_time, presence: true
end