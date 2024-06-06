class Group < ApplicationRecord
  
  # group_imageとういう名で画像を保存できるようにする
  has_one_attached :group_image
  
  # 作成時のバリデーション
  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  # inntoroductionに関するバリデーションの追加
  validates :introduction, length: {maximum: 50 }
  
  def get_group_image
    (group_image.attached?) ? group_image : 'no_image.jpg'
  end
  
end
