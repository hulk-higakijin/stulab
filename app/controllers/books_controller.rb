class BooksController < ApplicationController
  before_action :set_author, only: %i[new create edit update]
  before_action :set_book, only: %i[edit update destroy]

  def index
    @books = Book.published.includes(:user).with_attached_thumbnail
  end

  def show
    @book = Book.published.find(params[:id])
  end

  def new
    @book = @author.books.new
  end

  def edit; end

  def create
    @book = @author.books.new(book_params)
    @book.reservation!
    respond_to do |format|
      if @book.save
        format.html { redirect_to book_url(@book), notice: 'Book was successfully created.' }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to book_url(@book), notice: 'Book was successfully updated.' }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @book.destroy

    respond_to do |format|
      format.html { redirect_to books_url, notice: 'Book was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def set_author
      @author = current_user if current_user.author?
    end

    def set_book
      @book = @author.books.find(params[:id])
    end

    def book_params
      params.require(:book).permit(:title, :introduction, :price, :likes_count, :thumbnail)
    end
end
