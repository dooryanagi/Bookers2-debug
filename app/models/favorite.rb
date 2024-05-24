class Favorite < ApplicationRecord

  # いいねはuserに属している
  belongs_to :user
  # いいねはbookに属している
  belongs_to :book

  # 一対一の関係性になるようにバリデーション
  validates :user_id, uniqueness: {scope: :book_id}

end
