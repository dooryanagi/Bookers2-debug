class Book < ApplicationRecord
  
  # bookモデルはuserに属する
  belongs_to :user
  # bookはたくさんのいいねを持つ
  # bookが消えたらいいねも消えてもらう
  has_many :favorites, dependent: :destroy

  # カンマの後のスペースはどっちでもいい？
  validates :title, presence:true
  validates :body, presence:true, length:{maximum:200}
end
