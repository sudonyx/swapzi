class Swap < ApplicationRecord
  belongs_to :item_1, class_name: 'Item'
  belongs_to :item_2, class_name: 'Item'
  belongs_to :user_1, class_name: 'User'
  belongs_to :user_2, class_name: 'User'
end
