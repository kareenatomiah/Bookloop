class Book < ApplicationRecord
  belongs_to :category
  belongs_to :user
  has_many :be_reads, dependent: :destroy
  has_many :libraries, dependent: :destroy

  validates :category, presence: true
  validates :user, presence: true
end
