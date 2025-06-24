class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :be_read

  validates :body, presence: true
end
