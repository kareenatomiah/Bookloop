class BeReadsController < ApplicationController
  before_action :set_be_read, only: [:show, :destroy]

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
      redirect_to current_user, notice: "BeRead successfully created."
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

  private

  def set_be_read
    @be_read = BeRead.find(params[:id])
  end
end
