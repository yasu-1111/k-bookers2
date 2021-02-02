class UsersController < ApplicationController

  before_action :baria_user, only: [:edit]

  def index
    @users = User.all
    @book = Book.new
    @user = current_user
  end

  def show
    @user = User.find(params[:id])
    @book = Book.new
    @books = @user.books
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
       flash[:notice] = "You have updated user successfully."
       redirect_to user_path(@user.id)
    else
       render :edit
    end
  end

  def followings
    @user = User.find(params[:id])
    # byebug
    @followings = @user.following_user
  end

  def followers
    @user = User.find(params[:id])
    @followers = @user.follower_user
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

  def baria_user
    @user = User.find(params[:id])
    if @user != current_user
       redirect_to user_path(current_user)
    end
  end

end
