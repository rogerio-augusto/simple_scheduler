class MeetingsController < ApplicationController
  respond_to :html, :js

  def index
    if params[:start_date].present?
      @start_date = params[:start_date].to_date rescue Date.today
    else
      @start_date = Date.today
    end
    
    week_start = @start_date.beginning_of_week
    week_end = @start_date.end_of_week
    
    @meeting = Meeting.new
    @meetings = Meeting.where(starts_at: week_start..week_end)
    
    respond_with @meetings
  end
  
  def create
    @meeting = Meeting.new(meeting_params)
    @meeting.user = current_user

    @start_date = params[:start_date].to_date rescue Date.today.beginning_of_week
    @meetings = Meeting.all
    
    respond_to do |format|
      if @meeting.save
        @meetings = Meeting.all
        format.js { flash.now[:notice] = 'Criou a sala' }
      else
        format.js { flash.now[:error] = error_list_from @meeting }
      end
    end
  end

  private

    def meeting_params
      params.require(:meeting).permit(:starts_at, :ends_at)
    end
end