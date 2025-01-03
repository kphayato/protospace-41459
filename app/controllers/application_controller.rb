class ApplicationController < ActionController::Base
  # 全アクションでログインを要求するが、`index` と `show` アクションだけは除外
  before_action :authenticate_user!, except: [:index, :show]
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  # サインアップ時に追加フィールドを許可
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :profile, :occupation, :position])
  end

  # ログイン後のリダイレクト先を変更
  def after_sign_in_path_for(resource)
    prototypes_path # ここでリダイレクト先を指定
  end
end