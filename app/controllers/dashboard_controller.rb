class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @recent_books = Book.order(created_at: :desc).limit(5)
    @my_books = current_user.libraries
    @wishlist = []
    @categories = Category.all
  end
end
