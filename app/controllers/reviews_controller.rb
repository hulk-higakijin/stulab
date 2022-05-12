class ReviewsController < ApplicationController
  before_action :turbo_request?, only: [:index]

  def index
    @book = Book.find(params[:book_id])
    render layout: false, content_type: 'text/vnd.turbo-stream.html'
  end

  def create
    @book = Book.find(params[:book_id])
    @review = current_user.reviews.new(review_params)
    @review.book_id = @book.id
    @review.save!
  end

  def destroy; end

  private

    def turbo_request?
      raise ActionController::RoutingError, 'Not Found' unless turbo_frame_request?
    end

    def review_params
      params.require(:review).permit(:score, :message)
    end
end
