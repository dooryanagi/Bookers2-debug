class Book < ApplicationRecord
  
  # bookモデルはuserに属する
  belongs_to :user
  # bookはたくさんのいいねを持つ
  # bookが消えたらいいねも消えてもらう
  has_many :favorites, dependent: :destroy

  # カンマの後のスペースはどっちでもいい？
  validates :title, presence:true
  validates :body, presence:true, length:{maximum:200}
  
  # いいねの表示をすでにいいねをしたか否かで変更するためのメソッド定義
  # これを使うのはbookのビュー内なので、Bookモデルに定義
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

end
