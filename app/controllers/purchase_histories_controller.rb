class PurchaseHistoriesController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create]
  before_action :move_page, only: [:index, :create]

  def index
    @item = Item.find(params[:item_id])
    @purchase_history_shipping_address = PurchaseHistoryShippingAddress.new
  end

  def create
    @purchase_history_shipping_address = PurchaseHistoryShippingAddress.new(purchase_history_params)

    if @purchase_history_shipping_address.valid?
      card_pay
      @purchase_history_shipping_address.save
      redirect_to root_path
    else
      @item = Item.find(params[:item_id])
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

  def purchase_history_params
    params.require(:purchase_history_shipping_address)
          .permit(:postal_code, :prefecture_id, :city, :house_number, :building_name, :phone_number)
          .merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end

  def card_pay
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    item = Item.find(params[:item_id])

    Payjp::Charge.create(
      amount: item.price,
      card: purchase_history_params[:token],
      currency: 'jpy'
    )
  end
end
