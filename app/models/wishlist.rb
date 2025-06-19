class Wishlist < ApplicationRecord
  belongs_to :user

  validates :work_key, presence: true, uniqueness: { scope: :user_id }
end
