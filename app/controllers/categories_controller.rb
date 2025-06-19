class CategoriesController < ApplicationController
  def index
    # Récupère toutes les catégories distinctes présentes dans BookMetadatum
    @categories = BookMetadatum.select(:category).distinct.order(:category)
  end

  def show
    @category = params[:id] 
    @books = BookMetadatum.where(category: @category)
  end
end
