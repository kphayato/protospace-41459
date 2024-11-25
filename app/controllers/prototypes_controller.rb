class PrototypesController < ApplicationController
  # 未認証ユーザーをログインページにリダイレクトする処理を、必要なアクションにのみ適用
  before_action :move_to_index, except: [:index, :new, :create]
  before_action :set_prototype, only: [:edit, :update, :show, :destroy]

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
    @prototype = Prototype.find(params[:id])
  end

  def update
    @prototype = Prototype.find(params[:id])
    if @prototype.update(prototype_params)
      redirect_to @prototype, notice: 'プロトタイプが更新されました。'
    else
      render :edit
    end
  end

  def destroy
    @prototype = Prototype.find(params[:id])
    @prototype.destroy
    redirect_to prototypes_path, notice: 'プロトタイプが削除されました。'
  end

  private

  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image)
  end

  # 未認証ユーザーはログインページにリダイレクト
  def move_to_index
    unless user_signed_in?
      redirect_to new_user_session_path
    end
  end
end
