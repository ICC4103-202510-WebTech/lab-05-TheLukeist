class Ability
  include CanCan::Ability
  def initialize(user)
    return unless user.present?

    if user.admin?
      can :manage, :all
    else
      can :read, User, id: user.id
      can :create, Chat

      can :read, Chat do |chat|
        chat.sender_id == user.id || chat.receiver_id == user.id
      end
      can [:update, :destroy], Chat, sender_id: user.id

      can :create, Message
      can :read, Message do |message|
        chat = message.chat
        chat.sender_id == user.id || chat.receiver_id == user.id
      end
      can [:update, :destroy], Message, user_id: user.id
    end
  end
end