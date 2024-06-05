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
  # tagも必須にする
  validates :tag, presence:true, length:{maximum:20}


  # いいねの表示をすでにいいねをしたか否かで変更するためのメソッド定義
  # これを使うのはbookのビュー内なので、Bookモデルに定義
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

# 検索のために定義
  def self.search_for(content, method)
    if method == 'perfect'
      # 完全一致
      Book.where(title: content)
    elsif method == 'forward'
      # 前方一致
      Book.where('title LIKE ?',content + '%' )
    elsif method == 'backward'
      # 後方一致
      Book.where('title LIKE ?','%' + content )
    else
      # 部分一致
      Book.where('title LIKE ?','%' + content + '%' )
    end
  end

  # tag検索のために定義
  def self.tag_search_for(tag)
    Book.where(tag: tag)
  end

# 並び替えのために定義
  scope :latest, -> {order(created_at: :desc)}
  scope :star_count, -> {order(star: :desc)}

end
