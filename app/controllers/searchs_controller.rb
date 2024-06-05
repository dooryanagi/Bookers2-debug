class SearchsController < ApplicationController
  
  # searchアクションの定義
  def search
    # form_withの入力内容からそれぞれ取得
    @model = params[:model]
    @content = params[:content]
    @method = params[:method]
    # 選択されたモデルに応じてどこから探すか指定
    if @model == "user"
      # 検索結果を@recordsに代入
      @records = User.search_for(@content, @method)
    else
      @records = Book.search_for(@content, @method)
    end
  end
  
  # tag検索のために定義
  def tag_search
    @tag = params[:tag]
    @tag_records = Book.tag_search_for(@tag)
  end
  
end
