class BrowsingHistory < ApplicationRecord
  belongs_to :user
  belongs_to :item

  validates :item, uniqueness: { scope: :user }
end
