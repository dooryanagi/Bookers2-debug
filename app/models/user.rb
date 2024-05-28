class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # userはたくさんの本を持っている
  # userが消えたら本にも消えてもらう
  has_many :books, dependent: :destroy
  # userはたくさんのいいねを持っている
  # userが消えたらいいねにも消えてもらう
  has_many :favorites, dependent: :destroy
  # userはたくさんのコメントを持っている
  # userが消えたらコメントにも消えてもらう
  has_many :book_comments, dependent: :destroy
  
  # userはたくさんのfollowerを持っている
  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  # userはたくさんのfollowedを持っている
  has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy

  has_one_attached :profile_image

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  # inntoroductionに関するバリデーションの追加
  validates :introduction, length: {maximum: 50 }



  def get_profile_image
    # メソッドの定義の書き方が違うような、、、
    # サイズの引数の定義はここでは？、、、
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end
end
