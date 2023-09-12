class Item < ApplicationRecord
  belongs_to :user
  has_many :favourites
  has_many :comments
  has_many :item_1s, class_name: 'Swap'
  has_many :item_2s, class_name: 'Swap'
  has_many_attached :photos
end
