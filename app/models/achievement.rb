class Achievement < ApplicationRecord
  has_many :user_achievements
  has_many :users, through: :user_achievements
  has_one_attached :photo, dependent: :destroy

  def completed_by?(user)
    user_achievements.exists?(user: user)
  end
end
