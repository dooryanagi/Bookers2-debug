class FavoritesController < ApplicationController
  
  def create
    # いいねする本をURLから特定する
    book = Book.find(params[:book_id])
    # 新しいいいねを作成する、扱うことを許可されたカラムの情報を取得する
    favorite = Favorite.new(favorite_params)
    # いいねする人のidをcurrent_userメソッドで定義
    favorite.user_id = current_user.id
    # いいね情報を保存
    favorite.save
    # ひとつ前のページに戻る
    redirect_back
  end
  
  def destroy
  end
  
  
  private
  
  # createするときにモデルのテーブルを扱うために定義が必要
  def favorite_params
    params.require(:favorite).permit(:user_id, :book_id)
  end    

end
