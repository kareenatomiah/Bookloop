class User < ApplicationRecord
  has_many :wishlists, dependent: :destroy
  has_many :libraries, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 50 }, allow_blank: true
end
