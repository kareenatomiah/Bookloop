class User < ApplicationRecord
  # Associations
  has_many :books

  # Devise modules
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Validations
  validates :name, presence: true, length: { maximum: 50 }, allow_blank: true
end
