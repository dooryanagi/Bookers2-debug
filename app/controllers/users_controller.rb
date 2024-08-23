class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:update]
  before_action :ensure_guest_user, only: [:edit]


  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
    @start_last_month = START_LAST_MONTH
    @end_last_month = END_LAST_MONTH
    @start_two_month_ago = START_TWO_MONTH_AGO
    @end_two_month_ago = END_TWO_MONTH_AGO

    @current_entry = Entry.where(user_id: current_user.id)
    @another_entry = Entry.where(user_id: @user.id)
    unless @user.id == current_user.id
      # pluckでroom_idの配列にする ＋ ＆で共通要素を探す
      @room = Room.find(@current_entry.pluck(:room_id) & @another_entry.pluck(:room_id))
      # @is_roomを定義しなくても、↓のif文で分岐
      if @room.present?
        @is_room = true
      else
        @is_room = false
        @room = Room.new
        @entry = Entry.new
      end
    end
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

  # ゲストログインの場合、editができないように
  def ensure_guest_user
    # ゲストユーザも都度idが付与され、Userテーブルにデータとして蓄積される→idを持つ＝params[:id]で探すことができる
    @user = User.find(params[:id])
    if @user.guest_user?
      redirect_to user_path(current_user),notice: "ゲストユーザはプロフィール編集画面へ遷移は出来ません"
    end
  end



end
