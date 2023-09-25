class Conversation < ApplicationRecord
  belongs_to :user_1, class_name: 'User', foreign_key: :user_1_id
  belongs_to :user_2, class_name: 'User', foreign_key: :user_2_id
  has_many :messages, dependent: :destroy

  validates :user_1, presence: true
  validates :user_2, presence: true
  
  validate :validate_users_are_unique

  private

  def validate_users_are_unique
    if Conversation.where(user_1: user_1, user_2: user_2).or(Conversation.where(user_1: user_2, user_2: user_1)).exists?
      errors.add(:combo, 'User 1 and User 2 combination already exists!')
    end
  end
end
