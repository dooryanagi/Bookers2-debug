Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  #ログインに関わるので最初に持ってくる
  devise_for :users

  # ゲストログイン用のルーティング
  devise_scope :user do
    post "users/guest_sign_in", to: "users/sessions#guest_sign_in"
  end

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

  # userにネストしてrelationshipのルーティングをする
  resources :users, only: [:index,:show,:edit,:update] do
    resource :relationship, only: [:create, :destroy]
    # それぞれ一覧表示のためにアクションのルーティングを行う
    get :follows, on: :member
    get :followers, on: :member
  end

  # 検索機能の追加のために追加定義
  get "/search" => "searchs#search"
  # タグ検索の機能追加
  get "/tag_search" => "searchs#tag_search"

  # グループ機能の追加
  resources :groups, only: [:new, :edit, :index, :show, :create, :update] do
    # 間違ったここはgroup_userが良かった！
    resource :group_users, only: [:create, :destroy]
    # eventの追加
    resources :events, only: [:new, :create]
    # sentは自分で定義したアクションだからonlyオプションでは使えない
    get "/events/sent" => "events#sent"

  end

# DM機能
resources :rooms, only: [:create,:show] do
  resources :messages, only: [:create]
end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

# endの追加
end