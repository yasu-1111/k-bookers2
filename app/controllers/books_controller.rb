class BooksController < ApplicationController

  before_action :baria_user, only: [:edit]

  def index
    @books = Book.all
    @book = Book.new
    @user = current_user
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @books = Book.all
    @user = current_user
    if @book.save
       flash[:notice] = "You have created book successfully."
       redirect_to book_path(@book.id)
    else
       render :index
    end
  end

  def show
    @book_new = Book.new
    @book = Book.find(params[:id])
    @user = current_user
    @book_comment = BookComment.new
    @book_comments = @book.book_comments.page(params[:page]).reverse_order
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if
      @book.update(book_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(@book.id)
    else
      render :edit
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

private

def book_params
  params.require(:book).permit(:title, :body)
end

def baria_user
     @book = Book.find(params[:id])
  if @book.user != current_user
     redirect_to books_path
  end
end

end
