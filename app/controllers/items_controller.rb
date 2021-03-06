class ItemsController < ApplicationController
  # アクセス制御
  before_action :authenticate_user!, except: [:index, :show]
  before_action :move_page, only: [:edit, :update, :destroy]
  # 共通処理
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  def index
    @items = Item.includes(:user).order('created_at DESC')
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)

    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item)
    else
      render :edit
    end
  end

  def destroy
    @item.destroy
    redirect_to root_path
  end

  private

  def move_page
    item = Item.find(params[:id])

    # 自分が出品した商品以外、または売却済みの商品は編集・削除できない
    if (current_user.id != item.user.id) || !item.purchase_history.nil?
      redirect_to root_path
    end
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item)
          .permit(:name, :text, :image, :category_id, :status_id, :postage_defrayer_id, :prefecture_id, :day_to_ship_id, :price)
          .merge(user_id: current_user.id)
  end
end
