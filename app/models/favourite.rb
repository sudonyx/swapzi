class Favourite < ApplicationRecord
  belongs_to :item
  belongs_to :user

  validates :item, uniqueness: { scope: :user }
end
