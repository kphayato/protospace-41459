class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_current_user, only: [:show] # 現在ログインしているユーザーのみアクセス可能

  def show
    @user = User.find(params[:id])
  end

  private

  # 他のユーザーの詳細ページにアクセスできないようにする
  def ensure_current_user
    if current_user.id != params[:id].to_i
      redirect_to root_path, alert: '他のユーザーの詳細ページにはアクセスできません。'
    end
  end
end