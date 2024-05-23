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
    # user == current_userの設定の追加が必要
    @user = User.find(params[:id])
  end

  def update
    # findが必要
    @user = User.find(params[:id])
    if @user.update(user_params)
      # 更新したら更新したユーザーの詳細ページに行く
      # フラッシュメッセージはnoticeでもできる？
      redirect_to user_path(@user.id), notice: "You have updated user successfully."
    else
      # 異なるコントローラーの可能性もある、挙動確認
      # ダブルクオーテーションはとりあえずなしでは？？
      # render先はedit
      render :edit
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
