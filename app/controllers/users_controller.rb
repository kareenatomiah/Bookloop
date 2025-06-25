class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :update]

  def index
    # Implement user listing here if needed
  end

  def show
    # @user is set by before_action

    if current_user == @user
      @my_books = current_user.libraries # or current_user.my_books if that’s the right association
      @book_data = {}

      service = OpenLibraryService.new

      @my_books.each do |item|
        work_key = item.work_key
        work_data = service.get_work_details(work_key)
        next if work_data.blank?

        author_name = if work_data["authors"]&.first
                        author_key = work_data["authors"].first["author"]["key"]
                        author_data = service.get_author_details(author_key)
                        author_data["name"] rescue "Unknown"
                      else
                        "Unknown"
                      end

        @book_data[work_key] = {
          work_data: work_data,
          full_author: author_name,
          reviews: Review.where(work_key: work_key),
          local_metadata: BookMetadatum.find_by(work_key: work_key)
        }
      end
    else
      @my_books = []
      @book_data = {}
    end

    @user_be_reads = @user.be_reads.with_attached_photo.order(created_at: :desc)
  end

  def update
    # Only allow user to update their own profile
    unless current_user == @user
      redirect_to root_path, alert: "Not authorized"
      return
    end

    # Handle avatar upload if present
    if params[:user][:avatar_upload].present?
      # Purge existing avatar if any
      @user.avatar.purge if @user.avatar.attached?
      # Attach new avatar
      @user.avatar.attach(params[:user][:avatar_upload])
    end

    # Prepare update params excluding avatar_upload (already handled)
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
    # Permit avatar_upload as virtual attribute plus other user attributes
    params.require(:user).permit(:name, :email, :password, :date_of_birth, :country, :bio, :avatar_upload)
  end
end


