class Swap < ApplicationRecord
  belongs_to :item_1, class_name: 'Item', foreign_key: :item_1_id
  belongs_to :item_2, class_name: 'Item', foreign_key: :item_2_id
  belongs_to :user_1, class_name: 'User', foreign_key: :user_1_id
  belongs_to :user_2, class_name: 'User', foreign_key: :user_2_id
  has_many :user_reviews

  validates :user_1, presence: true
  validates :user_2, presence: true
  validates :item_1, presence: true
  validates :item_2, presence: true
end
