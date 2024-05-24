class Favorite < ApplicationRecord
  
  # 
  
  # 一対一の関係性になるようにバリデーション
  validates :user_id, uniqueness: {scope: :book_id}
  
end
