class DashboardController < ApplicationController
  before_action :authenticate_user!

def index
  @recent_books = Book.order(created_at: :desc).limit(5)
  @my_books = current_user.libraries
  @wishlist = current_user.wishlists
  @categories = Category.all

  @book_data = {}

  service = OpenLibraryService.new

  # ➤ Pour les livres de ma bibliothèque
  @my_books.each do |item|
    work_key = item.work_key
    work_data = service.get_work_details(work_key)
    next if work_data.blank?

    author_name = if work_data["authors"]&.first
                    author_key = work_data["authors"].first["author"]["key"]
                    author_data = service.get_author_details(author_key)
                    author_data["name"] rescue "Unknown"
                  else
                    "Unknown"
                  end

    @book_data[work_key] = {
      work_data: work_data,
      full_author: author_name,
      reviews: Review.where(work_key: work_key),
      local_metadata: BookMetadatum.find_by(work_key: work_key)
    }
  end

  # ➤ Pour les livres de la wishlist
  @wishlist.each do |item|
    work_key = item.work_key
    next if @book_data.key?(work_key) # pour ne pas refaire deux fois

    work_data = service.get_work_details(work_key)
    next if work_data.blank?

    author_name = if work_data["authors"]&.first
                    author_key = work_data["authors"].first["author"]["key"]
                    author_data = service.get_author_details(author_key)
                    author_data["name"] rescue "Unknown"
                  else
                    "Unknown"
                  end

    @book_data[work_key] = {
      work_data: work_data,
      full_author: author_name,
      reviews: [],
      local_metadata: {}
    }
    end
  end

  def show
  @my_books = current_user.libraries
  @wishlist = current_user.wishlists
  @categories = Category.all
  @book_data = fetch_all_book_data(@wishlist) # si besoin
  end


  def dashboard
  @my_books = current_user.libraries.includes(:user)

  @book_data = {}

  @my_books.each do |library|
    work_key = library.work_key
    work_data = fetch_open_library_data(work_key)
    full_author = extract_full_author(work_data)
    reviews = fetch_reviews_for(work_key)
    local_metadata = fetch_local_metadata(work_key)

    @book_data[work_key] = {
      work_data: work_data,
      full_author: full_author,
      reviews: reviews,
      local_metadata: local_metadata
    }
  end
end

end
