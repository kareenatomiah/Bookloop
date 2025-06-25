class User < ApplicationRecord
  # Associations
  has_many :wishlists, dependent: :destroy
  has_many :libraries, dependent: :destroy
  has_many :be_reads, dependent: :destroy
  has_many :books
  has_many :my_books, class_name: "Library"

  # Likes associations
  has_many :likes, dependent: :destroy
  has_many :liked_be_reads, through: :likes, source: :be_read

  # Friendships associations
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships

  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: 'friend_id', dependent: :destroy
  has_many :inverse_friends, through: :inverse_friendships, source: :user

  # ActiveStorage for avatar
  has_one_attached :avatar

  # Devise modules
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Validations
  validates :name, presence: true, length: { maximum: 50 }
  validates :username, presence: true, uniqueness: true, length: { maximum: 30 },
                       format: { with: /\A[a-zA-Z0-9_]+\z/, message: "only allows letters, numbers, and underscores" }

  attr_accessor :avatar_upload

  # Generate avatar thumbnail variant
  def avatar_thumbnail
    avatar.variant(resize_to_fill: [160, 160]).processed
  end

  # Returns true if the user has liked the given BeRead
  def liked?(be_read)
    liked_be_reads.exists?(be_read.id)
  end

  # Returns true if user is already friends with the given user
  def friends_with?(user)
    friends.include?(user)
  end
end

