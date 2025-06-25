class BeRead < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user

  has_one_attached :photo
  attr_accessor :photo_data

  validates :user, presence: true

  before_save :decode_photo_data, if: -> { photo_data.present? && !photo.attached? }
  after_create :update_user_streak

  private

  def decode_photo_data
    return unless photo_data.start_with?("data:image")

    # Extract content type from base64 header (e.g., "image/png" or "image/jpeg")
    match = photo_data.match(%r{\Adata:(image\/\w+);base64,})
    content_type = match[1] rescue "image/jpeg"

    base64_data = photo_data.sub(%r{\Adata:image\/\w+;base64,}, "")
    decoded_image = Base64.decode64(base64_data)

    extension = content_type.split("/").last
    filename = "be_read_#{SecureRandom.hex(10)}.#{extension}"

    self.photo.attach(
      io: StringIO.new(decoded_image),
      filename: filename,
      content_type: content_type
    )
  rescue StandardError => e
    Rails.logger.error("Failed to decode photo_data: #{e.message}")
  end

  def update_user_streak
    today = Date.current
    last = user.last_be_read_at

    if last == today - 1
      user.streak_count = user.streak_count.to_i + 1
    elsif last != today
      user.streak_count = 1
    end

    user.last_be_read_at = today
    user.save
  end
end

