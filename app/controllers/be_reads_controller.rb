class BeReadsController < ApplicationController

    def index
    @be_reads = BeRead.all
  end

  def new
    @be_read = BeRead.new
  end

  def create
    @be_read = BeRead.new(text: params[:be_read][:text])

    if params[:be_read][:photo_data].present?
      decoded_image = decode_base64_image(params[:be_read][:photo_data])
      @be_read.selfie.attach(
        io: decoded_image,
        filename: "selfie.jpg",
        content_type: "image/jpeg"
      )
    end

    if @be_read.save
      redirect_to current_user, notice: "BeRead successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

    def show
    @be_read = BeRead.find(params[:id])
  end

  def destroy
    @be_read = BeRead.find(params[:id])
    @be_read.destroy
    redirect_to be_reads_path, notice: "BeRead deleted."
  end

  private

  def decode_base64_image(data)
    image_data = data.sub(/^data:image\/\w+;base64,/, "")
    decoded_data = Base64.decode64(image_data)
    file = Tempfile.new(['selfie', '.jpg'])
    file.binmode
    file.write(decoded_data)
    file.rewind
    file
  end
end

