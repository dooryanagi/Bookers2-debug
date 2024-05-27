class BookCommentsController < ApplicationController

  def create
    # コメントするための本をURLをもとに探してくる
    @book = Book.find(params[:book_id])
    # 許可されたパラメータでコメントを新たに作る
    comment = BookComment.new(comment_params)
    # 必要なuser_id情報をcurrent_userメソッドで取得する
    # @bookとの関連付けが必要
    comment.book_id = @book.id
    # 誰がコメントしたかの情報も必要
    comment.user_id = current_user.id
    # コメントを保存する
    comment.save
    # 前のページに戻れなかった場合はそのまま詳細ページにいるようにする
    redirect_back fallback_location: book_path(params[:book_id])
  end

  def destroy
    BookComment.find(params[:id]).destroy
    redirect_to book_path(params[:book_id])
  end

  private

  def comment_params
    # user_id book_idは不要
    params.require(:book_comment).permit(:comment)
  end
end
