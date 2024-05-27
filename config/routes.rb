Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  #ログインに関わるので最初に持ってくる
  devise_for :users

  # root toの書き方の修正
  root to: 'homes#top'
  get "home/about"=>"homes#about"

  # ネストしたことでparams[:book_id]でbookのidをURLから取得できる
  # do~endが必要
  resources :books, only: [:index,:show,:edit,:create,:destroy,:update] do
    # booksに紐づいたルーティングにする
    # リンクにid情報が不要のためresourceで作成
    # resourceの時は紐づくモデルは単数形
    resource :favorite, only: [:create, :destroy]
    # book_comment用のルーティングを追加
    resources :book_comments, only: [:create, :destroy]
  end

  resources :users, only: [:index,:show,:edit,:update]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

# endの追加
end