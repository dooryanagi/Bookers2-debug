class Relationship < ApplicationRecord

  # それぞれフォロワーモデルとフォロゥイングモデルがあると考える
  # でも実際のフォローフォロワーはユーザーモデル←class_nameで元を
  belongs_to :follower, class_name: "User"
  belongs_to :following, class_name: "User"

  # バリデーション、考え方はfavoriteと一緒
  validates :follower_id, uniqueness: {scope: :following_id}

end
