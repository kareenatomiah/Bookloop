class Review < ApplicationRecord
  belongs_to :user
  belongs_to :book
  validates :content, presence: true
  validates :rating, presence: true, inclusion: 1..5
  validates :work_key, presence: true
end
