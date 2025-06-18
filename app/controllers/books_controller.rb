class BooksController < ApplicationController
  def index
    if params[:query].present?
      service = OpenLibraryService.new
      @books = service.search_books(params[:query]).map do |book|
      next unless book["key"] # skip si pas de work_key

      summary = service.get_work_ratings(book["key"])
      average = summary&.dig("average")
      count = summary&.dig("count")

      book.merge("average_rating" => average, "ratings_count" => count)
      end.compact
    else
      @books = []
    end
  end

  def show
    @work_key = params[:id] # ex: "/works/OL12345W"
    @book = OpenLibraryService.new.get_work_details(@work_key)

    # Optionnel : on récupère une édition
    editions = OpenLibraryService.new.get_editions_for_work(@work_key)
    @first_edition = editions.first if editions.any?

    # Optionnel : reviews locales associées au work_key
    @reviews = Review.where(work_key: @work_key)
  end

  def create
  end

  def update
  end

  def destroy
  end
end
