class Beread < ApplicationRecord
  belongs_to :user
  belongs_to :book
  has_one_attached :photo
end
