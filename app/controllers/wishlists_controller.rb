class WishlistsController < ApplicationController
  before_action :authenticate_user!

  def index
    @my_books = current_user.wishlists

    @book_data = @my_books.each_with_object({}) do |wishlist, hash|
      work_key = wishlist.work_key
      work_data = fetch_openlibrary_data(work_key)

      hash[work_key] = {
        work_data: work_data,
        full_author: extract_author(work_data),
        reviews: Review.where(work_key: work_key)
      }
    end
  end

  def create
    @wishlist = current_user.wishlists.new(work_key: params[:work_key])

    if @wishlist.save
      redirect_to book_path(params[:work_key]), notice: "➕ Book added to your wishlist!"
    else
      redirect_to book_path(params[:work_key]), alert: "❗ Already added or error."
    end
  end

  def destroy
    @wishlist = current_user.wishlists.find(params[:id])
    @wishlist.destroy
    redirect_to wishlists_path, notice: "Book removed from your wishlist."
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
