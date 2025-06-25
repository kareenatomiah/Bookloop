class BeReadsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_be_read, only: [:show, :destroy]
  before_action :authorize_user!, only: [:destroy]

  def index
    @be_reads = BeRead.with_attached_photo.order(created_at: :desc)
  end

  def new
    @be_read = BeRead.new
  end

  def create
    @be_read = current_user.be_reads.build(
      caption: params[:be_read][:caption],
      photo_data: params[:be_read][:photo_data]
    )

    if @be_read.save
      update_user_streak! # 💥🔥 On gère les flammes ici

      redirect_to confirm_post_be_read_path(@be_read), notice: "BeRead successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    # Loaded by before_action
  end

  def destroy
    @be_read.destroy
    redirect_to user_path(current_user), notice: "BeRead deleted."
  end

  def confirm_post
    @be_read = current_user.be_reads.find(params[:id])
    # Renders a view asking "Post to feed?"
  end

  def post_to_feed
    @be_read = current_user.be_reads.find(params[:id])
    @be_read.update(posted_on_feed: true)

    redirect_to feed_path, notice: "Your BeRead is now posted on your feed!"
  end

  private

  def set_be_read
    @be_read = BeRead.find(params[:id])
  end

  def authorize_user!
    unless @be_read.user == current_user
      redirect_to root_path, alert: "Not authorized to delete this BeRead."
    end
  end

  def be_read_params
    params.require(:be_read).permit(:caption, :photo_data, :photo)
  end

  # 🔥🔥🔥 Streak logic
  def update_user_streak!
    today = Date.current
    last = current_user.last_be_read_at

    if last == today - 1
      current_user.streak_count = current_user.streak_count.to_i + 1
    elsif last != today
      current_user.streak_count = 1
    end

    current_user.last_be_read_at = today
    current_user.save
  end
end
