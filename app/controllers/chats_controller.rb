class ChatsController < ApplicationController
  def index
    @chats = Chat.all
    @users = User.where(id: @chats.pluck(:sender_id, :receiver_id).flatten.uniq)
  end

  def show
    @chat = Chat.find(params[:id])
    @sender = User.find(@chat.sender_id)
    @receiver = User.find(@chat.receiver_id)
  end
end
