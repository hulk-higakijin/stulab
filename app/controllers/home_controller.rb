class HomeController < ApplicationController
  def index
    redirect_to books_path if user_signed_in?
    @books = Book.all.sample(3)
  end
end
