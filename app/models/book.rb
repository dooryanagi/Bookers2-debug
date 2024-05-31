class Book < ApplicationRecord
  
  # bookモデルはuserに属する
  belongs_to :user
  # bookはたくさんのいいねを持つ
  # bookが消えたらいいねも消えてもらう
  has_many :favorites, dependent: :destroy
  # bookはたくさんのコメントを持つ
  # bookが消えたらコメントも消えてもらう
  has_many :book_comments, dependent: :destroy

  # カンマの後のスペースはどっちでもいい？
  validates :title, presence:true
  validates :body, presence:true, length:{maximum:200}
  
  # いいねの表示をすでにいいねをしたか否かで変更するためのメソッド定義
  # これを使うのはbookのビュー内なので、Bookモデルに定義
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

# 検索のために定義
  def self.search_for(content, method)
    if method == 'perfect'
      # 完全一致
      Book.where(name: content)
    elsif method == 'forward'
      # 前方一致
      Book.where('name LIKE ?',content + '%' )
    elsif method == 'backward'
      # 後方一致
      Book.where('name LIKE ?','%' + content )
    else
      # 部分一致
      Book.where('name LIKE ?','%' + content + '%' )
    end
  end

end
