class ApplicationController < ActionController::Base
  # 権限の設定が必要、、、
  # exceptを指定する→top,about,
  before_action :authenticate_user!, except: [:top, :about]
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def after_sign_in_path_for(resource)
    # サインイン後はユーザーの詳細ページ
    # user.idだとどのユーザーか特定できない→current_user
    user_path(current_user)
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  def configure_permitted_parameters
    # サインアップ、サインインの両方をnameに
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
  end
end
