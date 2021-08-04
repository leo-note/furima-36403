class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

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

  private

  def item_params
    params.require(:item)
          .permit(:name, :text, :image, :category_id, :status_id, :postage_defrayer_id, :prefecture_id, :day_to_ship_id, :price)
          .merge(user_id: current_user.id)
  end
end
