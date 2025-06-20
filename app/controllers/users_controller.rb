class UsersController < ApplicationController
  before_action :authenticate_user!
  
  def index
  end

def show
  @user = User.find(params[:id])

  if current_user == @user
    @my_books = Book.all  # OU : Book.where(user_id: current_user.id) si tu as ça plus tard
  else
    @my_books = [] # Pour éviter d'afficher les livres des autres
  end
end


  def create
  end

  def update
  end

  def destroy
  end
end
