class BooksController < ApplicationController
  before_action :correct_book, only: [:edit]

  def index
  	@books = Book.all
    @book = Book.new
  end

  def show
    @book = Book.new
  	@book = Book.find(params[:id])
  end

  def create
  	@book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
  	   redirect_to book_path(@book.id), notice: 'Book was successfully created.'
    else
       render :index
    end
  end

  def new
    @book = Book.new(book_params)
    @books = Book.all
  end


  def edit
  	@book = Book.find(params[:id])
  end

  def update
  	@book = Book.find(params[:id])
    @book.user_id = current_user.id
    if @book.update(book_params)
      redirect_to book_path(@book.id), notice: 'Book was successfully updated.'
    else
      render :index
    end
  end

  def destroy
  	book = Book.find(params[:id])
  	book.destroy
  	redirect_to books_path, notice: 'Book was successfully destroyed.'
  end

  private
  def book_params
  	params.require(:book).permit(:title, :body)
  end
  def correct_book
    book = Book.find(params[:id])
    if book.user != current_user
      redirect_to books_path
    end
  end
end
