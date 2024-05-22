class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:update]

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end

  def index
    @users = User.all
    @book = Book.new
  # endの追加
  end

  def edit
    # アクション内容の定義
  end

  def update
    # findが必要
    if @user.update(user_params)
      redirect_to users_path(@user), notice: "You have updated user successfully."
    else
      # 異なるコントローラーの可能性もある、挙動確認
      # ダブルクオーテーションはとりあえずなしでは？？
      render :show
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
end
