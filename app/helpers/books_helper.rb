module BooksHelper
  def average_rating(ratings)
    ratings.pluck(:rating).sum.to_f / ratings.size
  end

end
