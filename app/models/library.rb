class Library < ApplicationRecord
  belongs_to :user
  belongs_to :book, optional: true

  validates :work_key, presence: true, uniqueness: { scope: :user_id }
end
