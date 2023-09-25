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
  
  validate :validate_items_are_unique, on: :create

  private

  def validate_items_are_unique
    if Swap.where(item_1: item_1, item_2: item_2).or(Swap.where(item_1: item_2, item_2: item_1)).exists?
      errors.add(:combo, 'User 1 and User 2 combination already exists!')
    end
  end
end
