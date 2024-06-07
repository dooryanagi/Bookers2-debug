class Event < ApplicationRecord

  # グループに属している
  belongs_to :group
 
 # 作成時のバリデーション
  validates :title, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :contents, length: {maximum: 100 }
  
end
