class ReviewsController < ApplicationController
  def create
    review = current_user.reviews.new(review_params)
    review.book_id = params[:book_id].to_i
    review.save!
  end

  def destroy; end

  private

    def review_params
      params.require(:review).permit(:score, :message)
    end
end
