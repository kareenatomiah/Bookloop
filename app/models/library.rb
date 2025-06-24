class Library < ApplicationRecord
  belongs_to :user
  belongs_to :book, optional: false  # Book must be present here

  validates :work_key, presence: true, uniqueness: { scope: :user_id }
  validates :book, presence: true    # Ensure book is present to avoid issues
end
