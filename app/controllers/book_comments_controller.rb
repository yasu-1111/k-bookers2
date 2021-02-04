class BookCommentsController < ApplicationController

  def create
    @book = Book.find(params[:book_id])
    @book_comment = current_user.book_comments.new(book_comment_params)
    @book_comment.book_id = @book.id
    if @book_comment.save
      @book_comments = @book.book_comments.page(params[:page]).reverse_order
    else
       @error_comment = comment
       @book = Book.find(params[:book_id])
       @book_comment = BookComment.new
       @user = current_user
       @book_comments = @book.book_comments.page(params[:page]).reverse_order
    end
  end

  def destroy
    @book_comment = BookComment.find(params[:id])
    @book = Book.find(params[:book_id])
    @book_comment.destroy
    @book_comments = @book.book_comments.page(params[:page]).reverse_order
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end

end
