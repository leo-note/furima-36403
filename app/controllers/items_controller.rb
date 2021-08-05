class ItemsController < ApplicationController
  # アクセス制御
  before_action :authenticate_user!, only: [:new, :create, :edit, :create]
  before_action :move_page, only: [:edit]
  # 共通処理
  before_action :set_item, only: [:show, :edit, :update]

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
    set_item
  end

  def edit
    set_item
  end

  def update
    set_item

    if @item.update(item_params)
      redirect_to item_path(@item)
    else
      render :edit
    end
  end

  private

  def move_page
    item = Item.find(params[:id])

    if current_user.id != item.user.id
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
