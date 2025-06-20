class BeReadsController < ApplicationController

  def index
  end

  def new
    @be_read = BeRead.new
  end

  def create
    @be_read = BeRead.new(be_read_params)
    if @be_read.save
      redirect_to @be_read, notice: "BeRead créé avec succès."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @be_read = BeRead.find(params[:id])
  end

  def destroy
  end

  private

  def be_read_params
    params.require(:be_read).permit(:selfie)
  end
end
