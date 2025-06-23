class BeRead < ApplicationRecord
  belongs_to :user
  belongs_to :book

  has_one_attached :photo
  attr_accessor :photo_data

  before_save :decode_photo_data, if: -> { photo_data.present? }

  validates :user, presence: true
  validates :book, presence: true

  private

  def decode_photo_data
    return unless photo_data.start_with?("data:image")

    content_type = 'image/jpeg'
    filename = "be_read_#{SecureRandom.hex(10)}.jpg"
    base64_str = photo_data.split(',')[1]
    decoded_image = Base64.decode64(base64_str)

    self.photo.attach(
      io: StringIO.new(decoded_image),
      filename: filename,
      content_type: content_type
    )
  end
end
