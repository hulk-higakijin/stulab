class ReviewsController < ApplicationController
  before_action :set_book
  before_action :turbo_request?, only: [:index]

  def index
    render layout: false, content_type: 'text/vnd.turbo-stream.html'
  end

  def create
    if !current_user.reviews.find_by(book_id: params[:book_id])
      @review = current_user.reviews.new(review_params)
      @review.book_id = @book.id
      @review.save!
    end
  end

  def destroy
    @review = current_user.reviews.find_by(book_id: params[:book_id])
    @review.destroy!
  end

  private

    def set_book
      @book = Book.find(params[:book_id])
    end

    def turbo_request?
      raise ActionController::RoutingError, 'Not Found' unless turbo_frame_request?
    end

    def review_params
      params.require(:review).permit(:score, :message)
    end
end
