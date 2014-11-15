class MeetingsController < ApplicationController
  respond_to :html, :js
  def index
    @start_date = params[:start_date] || DateTime.now.beginning_of_week

    if params[:room_id].present?
      @room = Room.find params[:room_id]
      @meetings = Meeting.where(room_id: params[:room_id])
    else
      @meetings = Meeting.all
    end
    
    respond_with @meetings
  end
end
