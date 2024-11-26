# PrototypesController
class PrototypesController < ApplicationController
  # アクセス制限
  before_action :move_to_index, only: [:edit, :update, :destroy]
  before_action :set_prototype, only: [:edit, :update, :show, :destroy]
  before_action :check_user_permission, only: [:edit, :update, :destroy]

  # 一覧表示
  def index
    @prototypes = Prototype.all
  end

  # 詳細表示
  def show; end

  # 新規作成フォーム
  def new
    @prototype = Prototype.new
  end

  # 新規作成処理
  def create
    @prototype = current_user.prototypes.build(prototype_params)
    if @prototype.save
      redirect_to @prototype, notice: 'プロトタイプが作成されました。'
    else
      render :new
    end
  end

  # 編集フォーム
  def edit; end

  # 更新処理
  def update
    if @prototype.update(prototype_params)
      redirect_to @prototype, notice: 'プロトタイプが更新されました。'
    else
      render :edit
    end
  end

  # 削除処理
  def destroy
    @prototype.destroy
    redirect_to prototypes_path, notice: 'プロトタイプが削除されました。'
  end

  private

  # Strong Parameters
  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image)
  end

  # ログインユーザーのみ編集・削除可能
  def move_to_index
    redirect_to root_path, alert: 'ログインが必要です。' unless user_signed_in?
  end

  # プロトタイプの取得
  def set_prototype
    @prototype = Prototype.find_by(id: params[:id])
    redirect_to root_path, alert: '該当するプロトタイプが見つかりません。' unless @prototype
  end

  # 他のユーザーのプロトタイプへの編集・削除を禁止
  def check_user_permission
    redirect_to root_path, alert: '他のユーザーのプロトタイプにはアクセスできません。' unless @prototype.user == current_user
  end
end