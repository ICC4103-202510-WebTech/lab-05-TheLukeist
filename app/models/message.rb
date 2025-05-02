class Message < ApplicationRecord
  # Asociaciones
  belongs_to :chat
  belongs_to :user

  # Validaciones
  validates :body, presence: true
  validates :chat_id, presence: true
  validates :user_id, presence: true
end 