class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :items
  has_many :favourites
  has_many :item_comments
  has_many :user_1s, class_name: 'Swap'
  has_many :user_2s, class_name: 'Swap'
  has_many :senders, class_name: 'Message'
  has_many :receivers, class_name: 'Message'
  has_many :reviewers, class_name: 'UserReview'
  has_many :revieweds, class_name: 'UserReview'
  has_one_attached :photo
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
