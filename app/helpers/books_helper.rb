module BooksHelper
  def average_rating(ratings)
    if ratings.exists?
      "#{ratings.average(:rating).to_f.round(1)} ☆"
    else
      "No ratings yet"
    end
  end

  def fetch_openlibrary_data(work_key)
    # ...
  end

  def extract_author(work_data)
    # ...
  end
end
