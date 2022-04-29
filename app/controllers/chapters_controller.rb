class ChaptersController < ApplicationController
  before_action :set_book

  def show
  end

  def new
    @chapter = @book.chapters.new
  end

  def create
    @chapter = @book.chapters.new(chapter_params)
    @chapter.number = @book.chapters.length
    if @chapter.save
      redirect_to book_path(@book)
    end
  end

  def edit
    @chapter = @book.chapters.find(params[:id])
  end

  def update
    @chapter = @book.chapters.find(params[:id])
    if @chapter.update(chapter_params)
      redirect_to book_path(@book)
    end
  end

  def destroy
    @chapter = @book.chapters.find(params[:id])
    if @chapter.number == @book.chapters.length
      @chapter.destroy!
      redirect_to book_path(@book)
    else
      puts '最後のチャプターのみ削除してください。'
    end
  end

  private

    def set_book
      @book = Book.find(params[:book_id])
    end

    def chapter_params
      params.require(:chapter).permit(:caption, :content)
    end

end
