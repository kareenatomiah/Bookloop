class BeReadsController < ApplicationController
  before_action :authenticate_user!

  def index
    @be_reads = BeRead.all.order(created_at: :desc)
  end

  def new
    @be_read = BeRead.new
    @books = current_user.books

    if params[:book_id].present?
      book = current_user.books.find_by(id: params[:book_id])
      @be_read.book = book if book
    end
  end

  def create
    @be_read = current_user.be_reads.new(be_read_params)
    decoded_image = nil

    if params[:be_read][:photo_data].present?
      decoded_image = decode_base64_image(params[:be_read][:photo_data])
      @be_read.selfie.attach(
        io: decoded_image,
        filename: "selfie.jpg",
        content_type: "image/jpeg"
      )
    end

    if @be_read.save
      redirect_to user_path(current_user), notice: "BeRead successfully created."
    else
      @books = current_user.books
      render :new, status: :unprocessable_entity
    end
  ensure
    decoded_image&.close
    decoded_image&.unlink
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

  def be_read_params
    params.require(:be_read).permit(:text, :book_id)
  end

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

