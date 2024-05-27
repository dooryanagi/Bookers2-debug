class FavoritesController < ApplicationController

  def create
    # いいねする本をURLから特定する
    book = Book.find(params[:book_id])
    # 新しいいいねを作成する、直接newする内容（カラム名、入れる情報名）を指定する
    favorite = Favorite.new(book_id: book.id)
    # いいねする人のidをcurrent_userメソッドで定義、これでfavoriteモデルの必要なカラムすべての情報を取得・定義
    favorite.user_id = current_user.id
    # いいね情報を保存
    favorite.save
    # ひとつ前のページに戻る
    redirect_back fallback_location: books_path
  end

  def destroy
    # いいねの削除をする本をURLから特定する
    book = Book.find(params[:book_id])
    # 削除するいいねを作成する、直接newする内容（カラム名、入れる情報名）を指定する
    favorite = Favorite.find_by(book_id: book.id)
    favorite.user_id = current_user.id
    favorite.destroy
    redirect_back fallback_location: books_path

  end

  # いいねに保存や取り出すときにデータを制限する必要はないため、SPは不要
  # private

  # createするときにモデルのテーブルを扱うために定義が必要
  # def favorite_params
    # params.require(:favorite).permit(:user_id, :book_id)
  # end

end
