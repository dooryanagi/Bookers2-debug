class RoomsController < ApplicationController

  def create
    @room = Room.create(user_id: current_user.id)
    @entry1 = Entry.create(room_id: @room.id, user_id: current_user.id)
    @entry2 = Entry.create(room_id: @room.id, user_id: params[:user_id])
    redirect_to room_path(@room.id)
  end

  def show
    @room = Room.find(params[:id])
    if Entry.where(user_id: current_user.id, room_id: @room.id).present?
      @messages = @room.messages
      @message = Message.new
      @entries = @room.entries
    #Roomで相手の名前表示するために記述
      # @my_user_id = current_user.id
    else
      redirect_back(fallback_location: root_path)
    end
  end

end
