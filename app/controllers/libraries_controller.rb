class LibrariesController < ApplicationController
  before_action :authenticate_user!

  def index
    @my_books = current_user.libraries

    @book_data = @my_books.each_with_object({}) do |library, hash|
      work_key = library.work_key
      work_data = fetch_openlibrary_data(work_key)
      local_metadata = BookMetadatum.find_by(work_key: work_key)
      reviews = Review.where(work_key: work_key)

      hash[work_key] = {
        work_data: work_data,
        full_author: extract_author(work_data, local_metadata),
        local_metadata: local_metadata,
        reviews: reviews
      }
    end
  end

  def create
    @library = current_user.libraries.new(work_key: params[:work_key])

    if @library.save
      redirect_to book_path(params[:work_key]), notice: "➕ Book added to your collection!"
    else
      redirect_to book_path(params[:work_key]), alert: "❗ Already added or error."
    end
  end

  def destroy
    @library = current_user.libraries.find(params[:id])
    @library.destroy
    redirect_to mybooks_path, notice: "❌ Book removed from your collection."
  end

  private

  def fetch_openlibrary_data(work_key)
    require 'net/http'
    require 'json'

    work_id = work_key.sub('/works/', '')
    url = URI("https://openlibrary.org/works/#{work_id}.json")

    begin
      response = Net::HTTP.get(url)
      JSON.parse(response)
    rescue StandardError => e
      Rails.logger.error("Error fetching OpenLibrary data: #{e.message}")
      {}
    end
  end

  def extract_author(work_data, local_metadata = nil)
    author_keys = work_data.dig("authors")&.map { |a| a.dig("author", "key") }

    if author_keys&.any?
      author_key = author_keys.first
      url = URI("https://openlibrary.org#{author_key}.json")

      begin
        response = Net::HTTP.get(url)
        author_data = JSON.parse(response)
        return author_data["name"]
      rescue StandardError => e
        Rails.logger.error("Error fetching author data: #{e.message}")
      end
    end

    # Fallbacks
    local_metadata&.author || "Unknown"
  end
end
