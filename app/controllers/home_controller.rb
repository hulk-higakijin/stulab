class HomeController < ApplicationController
  def index
    @books = Book.all.sample(3)
  end
end
