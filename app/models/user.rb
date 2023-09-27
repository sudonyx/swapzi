class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :items, dependent: :destroy
  has_many :favourites, dependent: :destroy
  has_many :item_comments
  has_many :user_1s, class_name: 'Swap', foreign_key: :user_1_id, dependent: :destroy
  has_many :user_2s, class_name: 'Swap', foreign_key: :user_2_id, dependent: :destroy
  has_many :user_1s, class_name: 'Conversation', foreign_key: :user_1_id, dependent: :destroy
  has_many :user_2s, class_name: 'Conversation', foreign_key: :user_2_id, dependent: :destroy
  has_many :reviewers, class_name: 'UserReview', foreign_key: :reviewer_id, dependent: :destroy
  has_many :revieweds, class_name: 'UserReview', foreign_key: :reviewed_id, dependent: :destroy
  has_one_attached :photo, dependent: :destroy
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :username, presence: true, uniqueness: true
  validates :location, presence: true
  validates :swapzi_score, presence: true, numericality: { only_integer: true }
end
