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
  @work_key = params[:id] # ex: /works/OL12345W
  service = OpenLibraryService.new
  @work = service.get_work_details(@work_key)

  # 🔍 On récupère les données locales si elles existent (auteur, description, catégorie)
@local_metadata = BookMetadatum.find_by(work_key: @work_key)


  # ⚠️ Si l’API renvoie une liste de clés d’auteurs, on récupère leurs noms
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
