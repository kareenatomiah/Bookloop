class User < ApplicationRecord
  has_many :wishlists, dependent: :destroy
  has_many :libraries, dependent: :destroy
  has_many :be_reads, dependent: :destroy
  has_many :books
  has_many :my_books, class_name: "Library"
  has_one_attached :avatar
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 50 }, allow_blank: true

  attr_accessor :avatar_upload

  def avatar_thumbnail
    avatar.variant(resize_to_fill: [160, 160]).processed
  end

  def liked?(be_read)
    likes.exists?(be_read_id: be_read.id)
  end
end
