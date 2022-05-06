class ChaptersController < ApplicationController
  before_action :set_book
  before_action :need_permission, only: %i[new create edit update destroy]
  before_action :set_chapter, only: %i[show edit update destroy]

  def show
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

  def edit; end

  def update
    redirect_to book_chapter_path(@book, @chapter) if @chapter.update(chapter_params)
  end

  def destroy
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

    def need_permission
      raise ActionController::RoutingError, 'Not Found' if @book.user.public_uid != current_user.public_uid
    end

    def set_chapter
      @chapter = @book.chapters.find(params[:id])
    end

    def chapter_params
      params.require(:chapter).permit(:caption, :content)
    end
end
