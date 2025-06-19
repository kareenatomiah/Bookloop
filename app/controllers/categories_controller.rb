class CategoriesController < ApplicationController
  def index
    # Get unique category names as strings
    @categories = BookMetadatum.select(:category).distinct.order(:category)
  end

  def show
    # Use params[:id] directly as category string
    @category = params[:id]
    # Fetch all books with this category
    @books = BookMetadatum.where(category: @category)
  end
end
