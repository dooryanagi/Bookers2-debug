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

  # ★フォローする側：フォローする人はたくさんのフォローされる人を持っている
  # userはたくさんのfollowerを持っている
  has_many :active_relationships, class_name: "Relationship", foreign_key: :following_id, dependent: :destroy
  # フォローしている人一覧の作成の準備
  has_many :followings, through: :active_relationships, source: :follower


  # ★フォローされる側：フォローされる人はたくさんのフォローしてくれる人を持っている
  has_many :passive_relationships, class_name: "Relationship", foreign_key: :follower_id, dependent: :destroy
  # フォローされている人一覧の作成の準備
  has_many :followers, through: :passive_relationships, source: :following

  has_one_attached :profile_image

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  # inntoroductionに関するバリデーションの追加
  validates :introduction, length: {maximum: 50 }

  def get_profile_image
    # メソッドの定義の書き方が違うような、、、
    # サイズの引数の定義はここでは？、、、
    # サイズの引数をどこでも指定できる[width,height]を引数にすることもできるし、今回のように各箇所で大きさを指定することもできる
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end
  
  # 自分のことはフォローできないようにメソッドを定義
  def followed_by?(user)
    passive_relationships.find_by(following_id: user.id).present?
  end  

  # 検索のために定義
  de
  
end
