class Swap < ApplicationRecord
  belongs_to :item_1, class_name: 'Item'
  belongs_to :item_2, class_name: 'Item'
  belongs_to :user_1, class_name: 'User'
  belongs_to :user_2, class_name: 'User'

  validates :user_1_id, presence: true
  validates :user_2_id, presence: true
  validates :item_1_id, presence: true
  validates :item_2_id, presence: true
end
