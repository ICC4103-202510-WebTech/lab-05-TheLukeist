class MessagesController < ApplicationController
  def index
    @messages = Message.all
    @users = User.where(id: @messages.pluck(:user_id).uniq)
  end

  def show
    @message = Message.find(params[:id])
    @user = User.find(@message.user_id)
  end
end
