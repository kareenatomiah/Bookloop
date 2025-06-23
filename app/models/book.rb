class Book < ApplicationRecord
  belongs_to :category
  belongs_to :user
  has_many :be_reads
end
