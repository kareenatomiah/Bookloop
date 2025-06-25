class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_be_read

  def create
    @comment = @be_read.comments.new(comment_params)
    @comment.user = current_user

    if @comment.save
      respond_to do |format|
        format.html { redirect_back fallback_location: be_reads_path }
        format.js
      end
    else
      redirect_back fallback_location: be_reads_path, alert: "Comment can't be blank."
    end
  end

  private

  def set_be_read
    @be_read = BeRead.find(params[:be_read_id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
