class BooksController < ApplicationController
  def index
    if params[:query].present?
      service = OpenLibraryService.new
      raw_results = service.search_books(params[:query])

      # Filter books that have key, cover, and the title matches query (case-insensitive)
      @books = raw_results.select do |book|
        book["key"].present? &&
        book["cover_i"].present? &&
        book["title"].to_s.downcase.include?(params[:query].downcase)
      end

      # Find a "main" book that matches the query exactly and has author(s)
      main_book = raw_results.find do |book|
        book["title"].to_s.downcase == params[:query].downcase &&
        book["author_name"].present?
      end

      if main_book
        author_name = main_book["author_name"].first

        # Find other books by the same author excluding the main book title
        author_books = raw_results.select do |book|
          book["cover_i"].present? &&
          book["author_name"]&.include?(author_name) &&
          book["title"].to_s.downcase != params[:query].downcase
        end

        # Add unique author books to the list
        @books += author_books
      end

      # Remove duplicate books by "key"
      @books.uniq! { |b| b["key"] }
    else
      @books = []
    end
  end

  def show
    # params[:id] expected to be something like "OL29226517W"
    @work_key = params[:id]
    service = OpenLibraryService.new

    # Fetch work details from the external service
    @work = service.get_work_details(@work_key)

    # Fetch any local metadata saved in the database
    @local_metadata = BookMetadatum.find_by(work_key: @work_key)

    # Fetch reviews associated with this work_key
    @reviews = Review.where(work_key: @work_key)

    # Assemble full author name(s)
    if @work && @work["authors"].present?
      authors = @work["authors"].map do |author_ref|
        author_key = author_ref["author"]["key"]
        details = service.get_author_details(author_key)
        details["name"] if details.present?
      end.compact

      @full_author = authors.join(", ")
    else
      # Fallback to local metadata or unknown
      @full_author = @local_metadata&.author || "Unknown"
    end
  end
end
