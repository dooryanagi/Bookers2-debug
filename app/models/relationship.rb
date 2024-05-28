class Relationship < ApplicationRecord
  
  # 関係性はフォロワーに属している、フォロワーはユーザー
  # ここのfollowerとfollowedはのちに_idで識別して持ってくる
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"
  
end
