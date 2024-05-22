class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  #userはたくさんの本を持っている  
  has_many :books
  
  has_one_attached :profile_image

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true

  
  
  def get_profile_image
    # メソッドの定義の書き方が違うような、、、
    # サイズの引数の定義はここでは？、、、
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end
end
