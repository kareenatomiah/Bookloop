# app/services/open_library_service.rb
class OpenLibraryService
  include HTTParty
  base_uri 'https://openlibrary.org'

  # 🔍 1. Recherche de livres par mot-clé
  # Exemple : /search.json?q=harry+potter
  def search_books(query)
    response = self.class.get("/search.json", query: { q: query })
    response.parsed_response["docs"]
  end

  # 🖼️ 2. URL de la couverture du livre
  # Utilise cover_id + taille (S, M, L)
  # Exemple : https://covers.openlibrary.org/b/id/12345-M.jpg
  def book_cover_url(cover_id, size = 'M')
    "https://covers.openlibrary.org/b/id/#{cover_id}-#{size}.jpg"
  end

  # 📘 3. Détails d'un "work" (œuvre)
  # Exemple : /works/OL12345W.json
  # Donne : titre, description, sujets, etc.
  def get_work_details(work_key)
    response = self.class.get("#{work_key}/ratings.json")
    return nil unless response.success?
    response.parsed_response["summary"]
  end

  # def get_work_ratings(work_key)
  # # Ex: work_key = "/works/OL45804W"
  # res = self.class.get("#{work_key}/ratings.json")
  # res.success? ? res.parsed_response["summary"] : nil
  # end

  # 📖 4. Détails d'une édition précise
  # Exemple : /books/OL7353617M.json
  def get_edition_details(edition_key)
    response = self.class.get("/books/#{edition_key}.json")
    response.parsed_response
  end

  # 📚 5. Liste des éditions d'une œuvre (work)
  # Exemple : /works/OL12345W/editions.json
  def get_editions_for_work(work_key)
    response = self.class.get("#{work_key}/editions.json")
    response.parsed_response["entries"]
  end

  # 👤 6. Détails d’un auteur
  # Exemple : /authors/OL123456A.json
  def get_author_details(author_key)
    response = self.class.get("#{author_key}.json")
    response.parsed_response
  end

  # 🏷️ 7. Recherche par sujet (optionnel)
  # Exemple : /subjects/love.json
  def get_books_by_subject(subject)
    response = self.class.get("/subjects/#{subject.downcase.gsub(" ", "_")}.json")
    response.parsed_response["works"]
  end
end
