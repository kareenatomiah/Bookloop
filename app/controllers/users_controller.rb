class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :update]

  def index
    # Implement user listing here if needed
  end

  def show
    service = OpenLibraryService.new
    @my_books = Library.where(user: @user)

    @book_data = {}

    @my_books.each do |item|
      work_key = item.work_key
      work_data = service.get_work_details(work_key)
      next if work_data.blank?

      author_name = if work_data["authors"] && work_data["authors"].any?
                      author_key = work_data["authors"][0]["author"]["key"]
                      author_data = service.get_author_details(author_key)
                      author_data["name"] rescue "Unknown Author"
                    else
                      "Unknown Author"
                    end

      cover_id = work_data["covers"]&.first

      @book_data[work_key] = OpenStruct.new(
        title: work_data["title"] || "Untitled",
        author: author_name,
        cover_id: cover_id,
        reviews: Review.where(work_key: work_key)
      )
    end

    @books = @book_data.values
    @bereads = @user.be_reads || []
  end


  def update
    unless current_user == @user
      redirect_to root_path, alert: "Not authorized"
      return
    end

    # Handle avatar upload if present
    if params[:user][:avatar_upload].present?
      @user.avatar.purge if @user.avatar.attached?
      @user.avatar.attach(params[:user][:avatar_upload])
    end

    update_params = user_params.except(:avatar_upload)

    if @user.update(update_params)
      redirect_to user_path(@user), notice: "Profile updated successfully."
    else
      flash.now[:alert] = "Failed to update profile."
      render :edit
    end
  end

  def create
    # Implement if needed
  end

  def destroy
    # Implement if needed
  end

  private

  def set_user
    @user = User.find(params[:id] || current_user.id)
  end

  def user_params
    params.require(:user).permit(
      :name, :email, :password, :date_of_birth, :country, :bio, :avatar_upload
    )
  end
end
