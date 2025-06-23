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
    response = self.class.get("#{work_key}.json")
    response.success? ? response.parsed_response : nil
  end

  # New helper to fetch enriched work data with author name and cover URL
  def fetch_full_work_data(work_key)
    work = get_work_details(work_key)
    return nil unless work

    # Extract title and covers
    title = work["title"] || "Untitled"
    covers = work["covers"] || []

    # Get first author name if possible
    full_author = "Unknown author"
    if work["authors"] && work["authors"].any?
      author_key = work["authors"].first["author"]["key"]
      author = get_author_details(author_key)
      full_author = author["name"] if author && author["name"]
    end

    # Build a hash that your controller/view can use
    {
      work_data: {
        title: title,
        covers: covers,
        description: work["description"].is_a?(Hash) ? work["description"]["value"] : work["description"],
        # Add any other fields needed here
      },
      full_author: full_author,
      # Provide a cover URL for the first cover if any
      cover_url: covers.any? ? book_cover_url(covers.first, 'M') : nil
    }
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
