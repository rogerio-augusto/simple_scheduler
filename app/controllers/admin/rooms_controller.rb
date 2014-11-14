class Admin::RoomsController < ApplicationController
  respond_to :html, :json, :js
  
  def index
    @rooms = Room.all
    respond_with @rooms
  end
  
  def new
    @room = Room.new
    respond_with @room
  end
    
  def create
    @room = Room.new room_params

    respond_to do |format|
      format.html do
        if @room.save
          flash.now[:notice] = 'Criou a sala'
          redirect_to admin_rooms_path
        else
          flash.now[:error] = error_list_from @room
          render :new
        end
      end
    end
  end
  
  def edit
    @room = Room.find params[:id]
    respond_with @room
  end
  
  def update
    @room = Room.find params[:id]
    
    respond_to do |format|
      format.html do
        if @room.update_attributes(room_params)
          flash.now[:notice] = 'Atualizado com sucesso'
          redirect_to admin_rooms_path
        else
          flash.now[:error] = error_list_from @room
          render :new
        end
      end
    end
  end
  
  def destroy
    @room = Room.find params[:id]
    
    respond_to do |format|
      format.js {
        if @room.destroy
          flash.now[:notice] = 'Apagou'
        else
          flash.now[:error] = 'erro'
        end
      }
    end
  end
  
  private

    def room_params
      params.require(:room).permit(:name, :pax_limit, :comments)
    end
    
end