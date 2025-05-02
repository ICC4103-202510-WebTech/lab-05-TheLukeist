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

  def new
    @chat = Chat.new
    @users = User.all
  end

  def create
    @chat = Chat.new(chat_params)
    if @chat.save
      redirect_to @chat, notice: 'Chat creado exitosamente.'
    else
      @users = User.all
      render :new, status: :unprocessable_entity
    end
  end

  private

  def chat_params
    params.require(:chat).permit(:sender_id, :receiver_id)
  end
end
