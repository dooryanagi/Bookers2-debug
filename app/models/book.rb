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
  # モデルを絡める必要がないから、コントローラーで定義すればよかったか？
  def self.tag_search_for(tag)
    Book.where(tag: tag)
  end

  # 投稿数カウントのメソッド（引数に開始日と終わり日を渡す）
  def self.number_of_book(start_date, end_date)
    start_of_day = start_date.beginning_of_day
    end_of_day = end_date.end_of_day
    Book.where(created_at: start_of_day..end_of_day).count
  end

  # 指定した日同士の投稿冊数割合の算出
  def self.percentage_of_books(start_term_1, end_term_1, start_term_2, end_term_2)
    number_of_divide = Book.number_of_book(start_term_1, end_term_1)
    number_of_dividend = Book.number_of_book(start_term_2, end_term_2)
    if number_of_divide == 0
      return 0
    else
      ratio = number_of_dividend / number_of_divide * 100
      return ratio
    end
  end

# 並び替えのために定義
  scope :latest, -> {order(created_at: :desc)}
  scope :star_count, -> {order(star: :desc)}

end
