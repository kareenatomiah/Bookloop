class User < ApplicationRecord
  # Associations
  has_many :wishlists, dependent: :destroy
  has_many :libraries, dependent: :destroy
  has_many :be_reads, dependent: :destroy
  has_many :books
  has_many :my_books, class_name: "Library"
  has_one_attached :avatar
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  # Devise modules for authentication
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Validations
  validates :name, presence: true, length: { maximum: 50 }, allow_blank: true

  # Virtual attribute (if you use it for uploads)
  attr_accessor :avatar_upload

  # Returns a resized avatar thumbnail for display
  def avatar_thumbnail
    avatar.variant(resize_to_fill: [160, 160]).processed
  end

  # Checks if the user liked a specific BeRead post
  def liked?(be_read)
    likes.exists?(be_read_id: be_read.id)
  end
end
