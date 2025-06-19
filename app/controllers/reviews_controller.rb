class ReviewsController < ApplicationController
  def new
    @work_key = params[:work_key]
    @review = Review.new
    load_work_details(@work_key)
  end

  def create
    @review = Review.new(review_params)
    @review.user = current_user

    if @review.save
      redirect_to book_path(@review.work_key), notice: "Review added successfully!"
    else
      load_work_details(@review.work_key)
      flash[:alert] = "Failed to create review."
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @review = Review.find(params[:id])
    @work_key = @review.work_key
    load_work_details(@work_key)
  end

  def update
    @review = Review.find(params[:id])

    if @review.update(review_params)
      redirect_to book_path(@review.work_key), notice: "Review updated successfully."
    else
      load_work_details(@review.work_key)
      flash.now[:alert] = "Failed to update review."
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    review = Review.find(params[:id])
    work_key = review.work_key
    review.destroy
    redirect_to book_path(work_key), notice: "Review deleted."
  end

  private

  def review_params
    params.require(:review).permit(:content, :rating, :work_key)
  end

  def load_work_details(work_key)
    service = OpenLibraryService.new
    @work = service.get_work_details(work_key)

    if @work && @work["authors"]
      authors = @work["authors"].map do |author_ref|
        author_key = author_ref["author"]["key"]
        author_data = service.get_author_details(author_key)
        author_data["name"] if author_data
      end.compact

      @full_author = authors.any? ? authors.join(", ") : "Unknown"
    else
      @full_author = "Unknown"
    end
  end
end
