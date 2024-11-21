class UsersController < ApplicationController
  def show
    @user = User.find(params[:id]) # URLに含まれるIDからユーザーを取得
    @prototypes = @user.prototypes # ユーザーが投稿したプロトタイプを取得
  end
end