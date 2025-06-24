class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_be_read

  def create
    @like = @be_read.likes.new(user: current_user)

    if @like.save
      respond_to do |format|
        format.html { redirect_back fallback_location: be_reads_path }
        format.js   # For AJAX, create.js.erb
      end
    else
      redirect_back fallback_location: be_reads_path, alert: "Unable to like."
    end
  end

  def destroy
    @like = @be_read.likes.find_by(user: current_user)
    @like&.destroy

    respond_to do |format|
      format.html { redirect_back fallback_location: be_reads_path }
      format.js   # For AJAX, destroy.js.erb
    end
  end

  private

  def set_be_read
    @be_read = BeRead.find(params[:be_read_id])
  end
end
