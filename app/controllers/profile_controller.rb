class ProfileController < ApplicationController
  before_action :authenticate_user!

  def index
    if params[:page].present?
      @books = current_user.books.public_send(params[:page])
    else
      @books = current_user.books.published
    end
  end
end
