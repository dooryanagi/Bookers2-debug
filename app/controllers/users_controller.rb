class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:update]

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end

  def index
    @users = User.all
    # _formの変数定義
    @book = Book.new
  # endの追加
  end

  def edit
    # アクション内容の定義
    @user = User.find(params[:id])
    # user == current_userの設定の追加が必要
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end

  def update
    # findが必要
    @user = User.find(params[:id])
    if @user.update(user_params)
      # 更新したら更新したユーザーの詳細ページに行く
      # フラッシュメッセージはnoticeでもできる？→できるはず？？
      redirect_to user_path(@user.id), notice: "You have updated user successfully."
    else
      # 異なるコントローラーの可能性もある、挙動確認
      # ダブルクオーテーションはとりあえずなしでは？？
      # render先はedit
      render :edit
    end
  end

  # フォロワー、フォローしている人の一覧を作成するためのメソッド
  def follows
    user = User.find(params[:id])
    # userモデルで定義したfollowings,この中にはたくさんのfollower_idが入っている
    @users = user.followings
  end

  def followers
    user = User.find(params[:id])
    # userモデルで定義したfollowers,この中にはたくさんのfollowing_idが入っている
    @users = user.followers
  end


  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  # アクションの一つ一つに定義しなくても、ここで本人以外ができないように指定することができる
  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
end
