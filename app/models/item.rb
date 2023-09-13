class Item < ApplicationRecord
  belongs_to :user
  has_many :favourites
  has_many :comments
  has_many :item_1s, class_name: 'Swap'
  has_many :item_2s, class_name: 'Swap'
  has_many_attached :photos

  validates :name, presence: true
  validates :description, presence: true
  validates :category, presence: true
  validates :swapzi_points, presence: true, numericality: { only_integer: true }
end
