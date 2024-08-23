class Room < ApplicationRecord
  # 勝手に作成される、実際はアソシエーションはない
  # belongs_to :user
  has_many :messages, dependent: :destroy
  has_many :entries, dependent: :destroy

end
