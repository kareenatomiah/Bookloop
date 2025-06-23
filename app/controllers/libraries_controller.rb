class LibrariesController < ApplicationController
  before_action :authenticate_user!

  def index
    @my_books = current_user.libraries

    @book_data = @my_books.each_with_object({}) do |library, hash|
      work_key = library.work_key
      work_data = fetch_openlibrary_data(work_key)

      hash[work_key] = {
        work_data: work_data,
        full_author: extract_author(work_data),
        reviews: Review.where(work_key: work_key)
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

  private

  # Fetch the OpenLibrary work data JSON for a given work_key
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

  # Extract first author name from work_data by fetching author data from OpenLibrary
  def extract_author(work_data)
    author_keys = work_data.dig("authors")&.map { |a| a.dig("author", "key") }
    return nil unless author_keys&.any?

    author_key = author_keys.first
    url = URI("https://openlibrary.org#{author_key}.json")

    begin
      response = Net::HTTP.get(url)
      author_data = JSON.parse(response)
      author_data["name"]
    rescue StandardError => e
      Rails.logger.error("Error fetching author data: #{e.message}")
      nil
    end
  end
end
