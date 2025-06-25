class User < ApplicationRecord
  has_many :wishlists, dependent: :destroy
  has_many :libraries, dependent: :destroy
  has_many :be_reads, dependent: :destroy
  has_many :books
  has_many :my_books, class_name: "Library"

  # Associations for Likes
  has_many :likes, dependent: :destroy
  has_many :liked_be_reads, through: :likes, source: :be_read

  has_one_attached :avatar

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 50 }, allow_blank: true

  attr_accessor :avatar_upload

  def avatar_thumbnail
    avatar.variant(resize_to_fill: [160, 160]).processed
  end

  # Returns true if the user has liked the given BeRead
  def liked?(be_read)
    liked_be_reads.exists?(be_read.id)
  end
end
