class BooksController < ApplicationController
def index
  if params[:query].present?
    service = OpenLibraryService.new
    raw_results = service.search_books(params[:query])

    # Étape 1 : filtrer les livres avec cover + mot-clé dans le titre
    @books = raw_results.select do |book|
      book["key"].present? &&
      book["cover_i"].present? &&
      book["title"].to_s.downcase.include?(params[:query].downcase)
    end

    # Étape 2 : trouver l’auteur du premier livre qui match exactement
    main_book = raw_results.find { |book| book["title"].to_s.downcase == params[:query].downcase && book["author_name"].present? }

    if main_book
      author_name = main_book["author_name"].first
      author_books = raw_results.select do |book|
        book["cover_i"].present? &&
        book["author_name"]&.include?(author_name) &&
        book["title"].to_s.downcase != params[:query].downcase # éviter doublon du livre principal
      end

      # Ajouter les livres du même auteur
      @books += author_books
    end

    # Supprimer doublons éventuels
    @books.uniq! { |b| b["key"] }
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

  # def search
  #   if params[:query].present?
  #   service = OpenLibraryService.new
  #   books = service.search_books(params[:query])
  #   render json: books
  # else
  #   render json: []
  #   end
  # end

  def create
  end

  def update
  end

  def destroy
  end
end
