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
  # userはたくさんのgroupuserになりうる
  has_many :group_users, dependent: :destroy


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
  def self.search_for(content, method)
    if method == 'perfect'
      # 完全一致
      User.where(name: content)
    elsif method == 'forward'
      # 前方一致
      User.where('name LIKE ?',content + '%' )
    elsif method == 'backward'
      # 後方一致
      User.where('name LIKE ?','%' + content )
    else
      # 部分一致
      User.where('name LIKE ?','%' + content + '%' )
    end
  end

  # ゲストログイン機能に関わるメソッド定義
  # 定数？の定義はモデル内にも可能
  GUEST_USER_EMAIL = "guest@example.com"

  # userというローカル変数にログインに必要な情報を持たせるためのメソッド
  def self.guest
    # データの検索と作成を自動的に判断して処理を行う
    # （）内の条件が存在すればそのデータを（email）、なければ新規作成する
    find_or_create_by!(email: GUEST_USER_EMAIL) do |user|
      # 適当にランダムなパスワードを作成してくれる
      user.password = SecureRandom.urlsafe_base64
      user.name = "guestuser"
    end
  end

  # trueかfalseを返す
  def guest_user?
    email == GUEST_USER_EMAIL
  end

end
