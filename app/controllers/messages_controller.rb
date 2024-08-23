class MessagesController < ApplicationController

  def create
    if Entry.where(:user_id => current_user.id, :room_id => params[:message][:room_id]).present?
      @room = Room.find(params[:room_id])
      @message = Message.create(user_id: current_user.id, room_id: @room.id, message: params[:message][:message])
      redirect_to room_path(@room)
    else
      redirect_back(fallback_location: users_path)
    end
  end

end
