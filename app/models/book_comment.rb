class BookComment < ApplicationRecord
  
    # コメントはuserに属している
  belongs_to :user
  # コメントはbookに属している
  belongs_to :book
  
  # 空のコメントは投稿できない
  validates :comment, presence:true
  
end
