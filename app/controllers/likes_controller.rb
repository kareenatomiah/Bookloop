class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_be_read

  # POST /be_reads/:be_read_id/like
  def create
    @like = @be_read.likes.new(user: current_user)

    if @like.save
      respond_to do |format|
        format.html { redirect_back fallback_location: be_reads_path }
        format.js
      end
    else
      redirect_back fallback_location: be_reads_path, alert: "Unable to like."
    end
  end

  # DELETE /be_reads/:be_read_id/like
  def destroy
    @like = @be_read.likes.find_by(user: current_user)
    @like&.destroy

    respond_to do |format|
      format.html { redirect_back fallback_location: be_reads_path }
      format.js
    end
  end

  private

  def set_be_read
    @be_read = BeRead.find(params[:be_read_id])
  end
end
