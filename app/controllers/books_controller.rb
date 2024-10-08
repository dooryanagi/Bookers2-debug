class BooksController < ApplicationController

  def show
    @book = Book.find(params[:id])
    #部分テンプレートで参照するために@userを定義
    # Userinfoには本を書いた人の情報を出すためidを取得
    # これだと本のidがユーザーにも入ってしまう
    #@ bookはfindで一つに定まっているので、アソシエーションしているモデル同士の表記でuserを特定できる
    @user = @book.user
    # コメントを投稿するための変数を定義
    @comment = BookComment.new
    # 閲覧数のカウント
    current_user.view_counts.where(created_at: Time.zone.now.all_day).find_or_create_by(book_id: @book.id)
  end

  def index
    # 並び替えのためにURLで指定された順番に並び替える
    if params[:latest]
      # モデルで定義した並び順で指定
      @books = Book.latest
    elsif params[:star_count]
      @books = Book.star_count
    else
      # @books = Book.all
      @books = Book.weekly_favorites
    end

    # 部分テンプレート（userinfo）呼び出しのために定義
    # アソシエーションにより、これで定義できるのではなかったっけ？
    # Book.allだから@book.userでは一つに絞ることは出来ない
    # indexの時は自分でよい！
    # @user = @books.user

    # 部分テンプレート（form）呼び出しのために定義
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    # createでの本人確認は不要？editにも追加？
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      # renderは''ではなく:
      # 異なるコントローラーの可能性もある、挙動確認
      render :index
    end
  end

  def edit
    @book = Book.find(params[:id])
    # 本人以外が編集できないように
    # リダイレクト先は本の一覧
    # なんでんだ？？→＝は代入、＝＝は同一であること
    unless @book.user_id == current_user.id
      redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      # renderは""ではなく:
      # 異なるコントローラーの可能性もある、挙動確認
      render :edit
    end
  end

  # delete→destroy
  def destroy
    @book = Book.find(params[:id])
    # destoy→destroy
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    # permitにbodyも追加
    # ★評価のために:starカラムを追加
    # タグの追加のために:tagカラムを追加
    params.require(:book).permit(:title, :body, :star, :tag)
  end
end
