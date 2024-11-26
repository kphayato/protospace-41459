class PrototypesController < ApplicationController
  # 未認証ユーザーをログインページにリダイレクトする処理を、必要なアクションにのみ適用
  before_action :move_to_index, only: [:edit, :update, :destroy] # 編集、更新、削除のみログイン必須
  before_action :set_prototype, only: [:edit, :update, :show, :destroy]
  before_action :check_user_permission, only: [:edit, :update, :destroy]

  def index
    @prototypes = Prototype.all
  end

  def show
    @prototype = Prototype.find(params[:id])
  end

  def new
    @prototype = Prototype.new
  end

  def create
    @prototype = current_user.prototypes.build(prototype_params)
    if @prototype.save
      redirect_to @prototype, notice: 'プロトタイプが作成されました。'
    else
      render :new
    end
  end

  def edit
    # 編集ページ
  end

  def update
    if @prototype.update(prototype_params)
      redirect_to @prototype, notice: 'プロトタイプが更新されました。'
    else
      render :edit
    end
  end

  def destroy
    @prototype.destroy
    redirect_to prototypes_path, notice: 'プロトタイプが削除されました。'
  end

  private

  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image)
  end

  # ログイン状態に関わらず、`index` アクションにはアクセス可能
  def move_to_index
    # 編集、更新、削除はログイン必須
    unless user_signed_in?
      redirect_to root_path, alert: 'ログインが必要です。' # ログインしていない場合、トップページにリダイレクト
    end
  end

  def set_prototype
    @prototype = Prototype.find(params[:id])
  end

  # 編集や削除操作で他ユーザーのプロトタイプにアクセスできないようにする
  def check_user_permission
    unless @prototype.user == current_user
      redirect_to root_path, alert: '他のユーザーのプロトタイプにはアクセスできません。'
    end
  end
end