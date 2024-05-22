class Book < ApplicationRecord
  
  # bookモデルはuserに属する
  belongs_to :user

  # カンマの後のスペースはどっちでもいい？
  validates :title, presence:true
  validates :body, presence:true, length:{maximum:200}
end
