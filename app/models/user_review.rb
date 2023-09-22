class UserReview < ApplicationRecord
  belongs_to :reviewer, class_name: 'User', foreign_key: :reviewer_id
  belongs_to :reviewed, class_name: 'User', foreign_key: :reviewed_id
  belongs_to :swap

  validates :rating, numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: 5 }
end
