class MessagesController < ApplicationController
  def index
    @messages = Message.all
    @users = User.where(id: @messages.pluck(:user_id).uniq)
  end

  def show
    @message = Message.find(params[:id])
    @user = User.find(@message.user_id)
  end

  def new
    @message = Message.new
    @chats = Chat.all
    @users = User.all
  end

  def create
    @message = Message.new(message_params)
    if @message.save
      redirect_to @message, notice: 'Mensaje creado exitosamente.'
    else
      @chats = Chat.all
      @users = User.all
      render :new, status: :unprocessable_entity
    end
  end

  private

  def message_params
    params.require(:message).permit(:chat_id, :user_id, :body)
  end
end
