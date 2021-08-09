require 'rails_helper'

RSpec.describe PurchaseHistoryShippingAddress, type: :model do
  before do
    # タイムアウト防止のためsleep処理を実施
    user = FactoryBot.create(:user)
    sleep 1.5
    item = FactoryBot.create(:item)
    sleep 1.5
    @purchase_history_shipping_address = FactoryBot.build(:purchase_history_shipping_address,
                                                          user_id: user.id, item_id: item.id)
    sleep 1.0
  end

  describe '商品購入' do
    context '商品購入できるとき' do
      it 'postal_code,prefecture_id,city,house_number,phone_number,user_id,item_id,tokenがあれば登録できる' do
        expect(@purchase_history_shipping_address).to be_valid
      end

      it 'building_nameがなくても登録できる' do
        @purchase_history_shipping_address.building_name = ''
        expect(@purchase_history_shipping_address).to be_valid
      end

      it 'phone_numberは10桁もしくは11桁なら登録できる' do
        # FactoryBotで生成するphone_numberは10桁なので10桁ケースは上記で実施済
        @purchase_history_shipping_address.building_name = 12345678901
        expect(@purchase_history_shipping_address).to be_valid
      end
    end

    context '商品購入できないとき' do
      it 'postal_codeがないとできない' do
        @purchase_history_shipping_address.postal_code = ''
        @purchase_history_shipping_address.valid?
        expect(@purchase_history_shipping_address.errors.full_messages).to include("Postal code can't be blank")
      end

      it 'prefecture_idがないと登録できない' do
        @purchase_history_shipping_address.prefecture_id = ''
        @purchase_history_shipping_address.valid?
        expect(@purchase_history_shipping_address.errors.full_messages).to include("Prefecture can't be blank")
      end

      it 'cityがないと登録できない' do
        @purchase_history_shipping_address.city = ''
        @purchase_history_shipping_address.valid?
        expect(@purchase_history_shipping_address.errors.full_messages).to include("City can't be blank")
      end

      it 'house_numberがないと登録できない' do
        @purchase_history_shipping_address.house_number = ''
        @purchase_history_shipping_address.valid?
        expect(@purchase_history_shipping_address.errors.full_messages)
              .to include("House number can't be blank")
      end

      it 'phone_numberがないと登録できない' do
        @purchase_history_shipping_address.phone_number = nil
        @purchase_history_shipping_address.valid?
        expect(@purchase_history_shipping_address.errors.full_messages)
              .to include("Phone number can't be blank")
      end

      it 'user_idがないと登録できない' do
        @purchase_history_shipping_address.user_id = nil
        @purchase_history_shipping_address.valid?
        expect(@purchase_history_shipping_address.errors.full_messages).to include("User can't be blank")
      end

      it 'itemがないと登録できない' do
        @purchase_history_shipping_address.item_id = nil
        @purchase_history_shipping_address.valid?
        expect(@purchase_history_shipping_address.errors.full_messages).to include("Item can't be blank")
      end

      it 'tokenがないと登録できない' do
        @purchase_history_shipping_address.token = nil
        @purchase_history_shipping_address.valid?
        expect(@purchase_history_shipping_address.errors.full_messages).to include("Token can't be blank")
      end

      it 'postal_codeは「xxx-xxxx」の半角文字列以外は保存できない' do
        @purchase_history_shipping_address.postal_code = '1234aaa'
        @purchase_history_shipping_address.valid?
        expect(@purchase_history_shipping_address.errors.full_messages).to include("Postal code is invalid")
      end

      it 'prefecture_idは半角数字以外は登録できない' do
        @purchase_history_shipping_address.prefecture_id = 'a'
        @purchase_history_shipping_address.valid?
        expect(@purchase_history_shipping_address.errors.full_messages).to include("Prefecture is not a number")
      end

      it 'prefecture_idは1は登録できない' do
        @purchase_history_shipping_address.prefecture_id = 1
        @purchase_history_shipping_address.valid?
        expect(@purchase_history_shipping_address.errors.full_messages).to include("Prefecture must be other than 1")
      end

      it 'phone_numberは半角数字以外は登録できない' do
        @purchase_history_shipping_address.phone_number = 'aaaaabbbbb'
        @purchase_history_shipping_address.valid?
        expect(@purchase_history_shipping_address.errors.full_messages).to include("Phone number is not a number")
      end

      it 'phone_numberは9桁以下だと登録できない' do
        @purchase_history_shipping_address.phone_number = 123456789
        @purchase_history_shipping_address.valid?
        expect(@purchase_history_shipping_address.errors.full_messages).to include("Phone number is too short (minimum is 10 characters)")
      end

      it 'phone_numberは12桁以上だと登録できない' do
        @purchase_history_shipping_address.phone_number = 123456789012
        @purchase_history_shipping_address.valid?
        expect(@purchase_history_shipping_address.errors.full_messages).to include("Phone number is too long (maximum is 11 characters)")
      end
    end
  end
end
