class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :update]

  def index
    if params[:query].present?
      @users = User.where("name ILIKE ?", "%#{params[:query]}%").where.not(id: current_user.id)
    else
      @users = []
    end
  end

  def show
    if current_user == @user
      @my_books = current_user.libraries
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

    # Load BeReads for the profile
    @user_be_reads = @user.be_reads.with_attached_photo.order(created_at: :desc)

    # Load friends for profile view (important for the Instagram-style friends list)
    @friends = @user.friends

    # Friendship status
    @is_friend = current_user.friends_with?(@user)
  end

  def update
    unless current_user == @user
      redirect_to root_path, alert: "Not authorized"
      return
    end

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
    # Not used
  end

  def destroy
    # Not used
  end

  private

def set_user
  @user = User.find_by(id: params[:id])

  if @user.nil?
    redirect_to root_path, alert: "User not found"
  end
end

  def user_params
    params.require(:user).permit(:name, :email, :password, :date_of_birth, :country, :bio, :avatar_upload)
  end
end
