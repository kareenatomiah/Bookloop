class Like < ApplicationRecord
  belongs_to :user
  belongs_to :be_read

  validates :user_id, uniqueness: { scope: :be_read_id }
end
