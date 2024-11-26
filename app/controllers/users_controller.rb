class UsersController < ApplicationController
  before_action :authenticate_user! # ログインしていないユーザーをブロック
  before_action :correct_user, only: [:show]

  def show
    @user = User.find(params[:id])
  end

  private

  def correct_user
    # 現在ログイン中のユーザーと一致するか確認
    unless current_user.id == params[:id].to_i
      flash[:alert] = "他のユーザーのページにはアクセスできません。"
      redirect_to root_path # アクセス拒否時のリダイレクト先
    end
  end
end