class PurchaseHistoriesController < ApplicationController
  # アクセス制御
  before_action :authenticate_user!, only: [:index, :create]
  before_action :move_page, only: [:index, :create]
  # 共通処理
  before_action :set_item, only: [:index]

  def index
    @purchase_history_shipping_address = PurchaseHistoryShippingAddress.new
  end

  def create
    @purchase_history_shipping_address = PurchaseHistoryShippingAddress.new(purchase_history_params)

    if @purchase_history_shipping_address.valid?
      card_pay
      @purchase_history_shipping_address.save
      redirect_to root_path
    else
      set_item
      render :index
    end
  end

  private

  def move_page
    item = Item.find(params[:item_id])

    # 自分が出品した商品、または売却済みの商品は購入できない
    if (current_user.id == item.user.id) || !item.purchase_history.nil?
      redirect_to root_path
    end
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def purchase_history_params
    params.require(:purchase_history_shipping_address)
          .permit(:postal_code, :prefecture_id, :city, :house_number, :building_name, :phone_number)
          .merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end

  def card_pay
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    set_item

    Payjp::Charge.create(
      amount: @item.price,
      card: purchase_history_params[:token],
      currency: 'jpy'
    )
  end
end
