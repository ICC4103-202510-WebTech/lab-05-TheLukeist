class ChatsController < ApplicationController
  load_and_authorize_resource
  before_action :set_chat, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  def index
    @chats = Chat.for_user(current_user)
    @users = User.where(id: @chats.pluck(:sender_id, :receiver_id).flatten.uniq)
  end

  def show
    @sender = User.find(@chat.sender_id)
    @receiver = User.find(@chat.receiver_id)
    @messages = @chat.messages
  end

  def new
    @chat = Chat.new
    @users = User.all
  end

  def create
    @chat = Chat.new(chat_params)
    @chat.sender = current_user

    if params[:chat][:sender_id].to_i != current_user.id
      @chat.errors.add(:sender_id, 'debe ser tu usuario actual')
      @users = User.all
      render :new, status: :unprocessable_entity
      return
    end

    if @chat.save
      redirect_to @chat, notice: 'Chat creado exitosamente.'
    else
      @users = User.all
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @users = User.all
  end

  def update
    if @chat.update(chat_params)
      redirect_to @chat, notice: 'Chat actualizado exitosamente.'
    else
      @users = User.all
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @chat.destroy
    redirect_to chats_path, notice: 'Chat eliminado exitosamente.'
  end

  private

  def set_chat
    @chat = Chat.find(params[:id])
  end

  def chat_params
    params.require(:chat).permit(:receiver_id)
  end
end
