class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    # Implement user listing here if needed
  end

  def show
    @user = User.find(params[:id])

    # Load books only if viewing own profile
    if current_user == @user
      @my_books = @user.books
    else
      @my_books = []
    end

    # Load BeReads for this user ordered newest first
    # Use `with_attached_photo` to eager load ActiveStorage attachments (the photos)
    @user_be_reads = @user.be_reads.with_attached_photo.order(created_at: :desc)
  end

  def create
    # Implement if needed
  end

  def update
    # Implement if needed
  end

  def destroy
    # Implement if needed
  end
end
