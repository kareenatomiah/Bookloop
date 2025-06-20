class User < ApplicationRecord
  has_many :wishlists, dependent: :destroy
  has_many :libraries, dependent: :destroy
  has_one_attached :avatar

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 50 }, allow_blank: true
end
