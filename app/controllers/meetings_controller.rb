class MeetingsController < ApplicationController
  respond_to :html, :js
  
  before_filter :setup_calendar_variables

  def index
    @meetings = Meeting.where(starts_at: @week_start..@week_end)
    respond_with @meetings
  end
  
  def create
    @meeting = Meeting.new(meeting_params)
    @meeting.user = current_user
    
    respond_to do |format|
      if @meeting.save
        # reload meetings
        @meetings = Meeting.where(starts_at: @week_start..@week_end)
        format.js { flash.now[:notice] = I18n.t('flash_messages.record_successfully_created') }
      else
        format.js { flash.now[:error] = error_list_from @meeting }
      end
    end
  end
  
  def destroy
    @meeting = Meeting.find(params[:id])
    
    respond_to do |format|
      if @meeting.destroy
        # reload meetings
        @meetings = Meeting.where(starts_at: @week_start..@week_end)
        format.js { flash.now[:notice] = I18n.t('flash_messages.record_successfully_deleted') }
      else
        format.js { flash.now[:error] = error_list_from @meeting }
      end
    end
  end

  private

    def meeting_params
      params.require(:meeting).permit(:starts_at, :ends_at)
    end
    
    def setup_calendar_variables
      starts_at = params[:meeting].try(:[],:starts_at)
      starts_at ||= params[:start_date]

      if starts_at.present?
        @start_date = starts_at.to_date rescue Date.today
      else
        @start_date = Date.today
      end
    
      @week_start = @start_date.beginning_of_week
      @week_end = @start_date.end_of_week    
      @meeting = Meeting.new
    end
end