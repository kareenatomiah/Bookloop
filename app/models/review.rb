class Review < ApplicationRecord
  belongs_to :user
  belongs_to :book
  validates :content, :rating, presence: true
end
