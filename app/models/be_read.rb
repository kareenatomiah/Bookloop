class BeRead < ApplicationRecord
  attr_accessor :photo_data

  belongs_to :user
  belongs_to :book

  has_one_attached :selfie

  validates :text, presence: true
  validates :book_id, presence: true
end
