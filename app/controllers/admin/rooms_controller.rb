class Admin::RoomsController < ApplicationController
  respond_to :html, :json
  
  def index
    @rooms = Room.all
    respond_with @rooms
  end
end