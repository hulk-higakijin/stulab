class ChaptersController < ApplicationController
  before_action :set_book

  def show
    @chapter = @book.chapters.find(params[:id])
    @pre_chapter = @book.chapters.find_by(number: @chapter.number - 1)
    @next_chapter = @book.chapters.find_by(number: @chapter.number + 1)
  end

  def new
    @chapter = @book.chapters.new
  end

  def create
    @chapter = @book.chapters.new(chapter_params)
    @chapter.number = @book.chapters.length
    redirect_to book_chapter_path(@book, @chapter) if @chapter.save
  end

  def edit
    @chapter = @book.chapters.find(params[:id])
  end

  def update
    @chapter = @book.chapters.find(params[:id])
    redirect_to book_chapter_path(@book, @chapter) if @chapter.update(chapter_params)
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
