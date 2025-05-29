class MessagesController < ApplicationController
  load_and_authorize_resource
  before_action :set_message, only: [:show, :edit, :update, :destroy]

  def index
    @messages = Message.all
    @users = User.where(id: @messages.pluck(:user_id).uniq)
  end

  def show
    @user = User.find(@message.user_id)
    @chat = @message.chat
  end

  def new
    @message = Message.new
    @chats = Chat.all
    @users = User.all
  end

  def create
    @message = Message.new(message_params)
    @message.user = current_user

    chat = Chat.find_by(id: @message.chat_id)
    unless chat && (chat.sender_id == current_user.id || chat.receiver_id == current_user.id)
      @message.errors.add(:chat_id, 'debes ser participante del chat para enviar un mensaje')
      @chats = Chat.all
      @users = User.all
      render :new, status: :unprocessable_entity
      return
    end

    if @message.save
      redirect_to @message, notice: 'Mensaje creado exitosamente.'
    else
      @chats = Chat.all
      @users = User.all
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @chats = Chat.all
    @users = User.all
  end

  def update
    if @message.update(message_params)
      redirect_to @message, notice: 'Mensaje actualizado exitosamente.'
    else
      @chats = Chat.all
      @users = User.all
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @message.destroy
    redirect_to messages_path, notice: 'Mensaje eliminado exitosamente.'
  end

  private

  def set_message
    @message = Message.find(params[:id])
  end

  def message_params
    params.require(:message).permit(:chat_id, :user_id, :body)
  end
end
