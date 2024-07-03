# deviseのコントローラを継承する（セッションズコントローラがあればそこに定義）
class Users::SessionsController < Devise::SessionsController
  
  def guest_sign_in
    # user.rbにguestメソッドを定義
    user = User.guest
    sign_in user
    redirect_to user_path(user), notice: "guestuserでログインしました。"
  end
endrail