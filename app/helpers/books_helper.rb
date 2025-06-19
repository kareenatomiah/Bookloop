module BooksHelper
  def average_rating(ratings)
    ratings.pluck(:rating).sum / ratings.size
  end

end
