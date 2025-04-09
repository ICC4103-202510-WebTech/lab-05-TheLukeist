class Message < ApplicationRecord
  validates :chat_id, presence: true
  validates :user_id, presence: true
  validates :body, presence: true
end 