class ApplicationController < ActionController::Base
  # 権限の設定が必要、、、
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def after_sign_in_path_for(resource)
    # サインイン後はユーザーの詳細ページ
    user_path(user.id)
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  def configure_permitted_parameters
    # サインアップ、サインインの両方をnameに
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
  end
end
