class UserAchievement < ApplicationRecord
  belongs_to :user
  belongs_to :achievement

  validates :user, uniqueness: { scope: :achievement }
end
