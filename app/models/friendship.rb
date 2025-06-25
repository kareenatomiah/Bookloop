class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  validates :user_id, uniqueness: { scope: :friend_id, message: "is already friends with this user" }

  # Prevent adding yourself as a friend
  validate :cannot_friend_self

  private

  def cannot_friend_self
    errors.add(:friend_id, "can't be the same as user") if user_id == friend_id
  end
end

