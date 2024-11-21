# app/controllers/comments_controller.rb
class CommentsController < ApplicationController
  before_action :set_prototype  # コメントが関連するプロトタイプをセット

  # コメントを作成するアクション
  def create
    @comment = @prototype.comments.new(comment_params)  # プロトタイプに関連するコメントを作成
    @comment.user = current_user  # 現在ログインしているユーザーをコメントの投稿者として設定

    if @comment.save
      # コメントが保存に成功した場合、プロトタイプの詳細ページにリダイレクト
      redirect_to prototype_path(@prototype), notice: 'コメントが投稿されました。'
    else
      # コメントの保存に失敗した場合、エラーメッセージと共にプロトタイプの詳細ページにリダイレクト
      redirect_to prototype_path(@prototype), alert: 'コメントの投稿に失敗しました。'
    end
  end

  private

  # プロトタイプをセットする
  def set_prototype
    @prototype = Prototype.find(params[:prototype_id])
  end

  # コメントのパラメーターを許可
  def comment_params
    params.require(:comment).permit(:content)  # コメントの内容を許可
  end
end