class BeRead < ApplicationRecord
  belongs_to :user
  belongs_to :book
  has_one_attached :selfie

  validates :text, presence: true
end
