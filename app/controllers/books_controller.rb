class BooksController < ApplicationController
  def index
    if params[:query].present?
      service = OpenLibraryService.new
      raw_results = service.search_books(params[:query])

      @books = raw_results.select do |book|
        book["key"].present? &&
        book["cover_i"].present? &&
        book["title"].to_s.downcase.include?(params[:query].downcase)
      end

      main_book = raw_results.find { |book| book["title"].to_s.downcase == params[:query].downcase && book["author_name"].present? }

      if main_book
        author_name = main_book["author_name"].first
        author_books = raw_results.select do |book|
          book["cover_i"].present? &&
          book["author_name"]&.include?(author_name) &&
          book["title"].to_s.downcase != params[:query].downcase
        end
        @books += author_books
      end

      @books.uniq! { |b| b["key"] }
    else
      @books = []
    end
  end

  def show
    # params[:id] is something like "OL29226517W"
    @work_key = params[:id]
    service = OpenLibraryService.new
    @work = service.get_work_details(@work_key)
    @local_metadata = BookMetadatum.find_by(work_key: @work_key)
    @reviews = Review.where(work_key: @work_key)

    if @work && @work["authors"]
      authors = @work["authors"].map do |author_ref|
        author_key = author_ref["author"]["key"]
        details = service.get_author_details(author_key)
        details["name"] if details
      end.compact
      @full_author = authors.join(", ")
    else
      @full_author = @local_metadata&.author || "Unknown"
    end
  end
end
