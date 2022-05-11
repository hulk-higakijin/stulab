class ReviewsController < ApplicationController
  def create
    @book = Book.find(params[:book_id])
    @review = current_user.reviews.new(review_params)
    @review.book_id = @book.id
    @review.save
  end

  def destroy; end

  private

    def review_params
      params.require(:review).permit(:score, :message)
    end
end
