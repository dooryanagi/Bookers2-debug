class Group < ApplicationRecord

  # group_imageとういう名で画像を保存できるようにする
  has_one_attached :group_image

  # グループはたくさんのグループユーザがいる、グループがなくなったらグループユーザーもなくなる
  has_many :group_users, dependent: :destroy
  
  # グループはたくさんのイベントを持っている、グループがなくなったらイベントもなくなる
  has_many :events, dependent: :destroy

  # 作成時のバリデーション
  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  # inntoroductionに関するバリデーションの追加
  validates :introduction, length: {maximum: 50 }

  def get_group_image
    (group_image.attached?) ? group_image : 'no_image.jpg'
  end

  # Groupモデル内ですでにグループに参加済みか否かで表記を分けたい
  # joined_in?メソッドはgroupモデル内で定義
  def joined_by?(user)
    group_users.exists?(user_id: user.id)
  end

end
