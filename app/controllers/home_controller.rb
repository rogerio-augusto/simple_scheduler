class HomeController < ApplicationController
  def index
    @start_date = params[:start_date] || DateTime.now.beginning_of_week
    @meeting = Meeting.new
    @meetings = Meeting.all
  end
end
