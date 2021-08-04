require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品機能' do
    context '商品出品できるとき' do
      it 'name,text,category_id,status_id,postage_defrayer_id,prefecture_id,
          day_to_ship_id,price,user,imageがあれば登録できる' do
        expect(@item).to be_valid
      end

      it 'priceは300以上の値(で9,999,999以下の値)であれば登録できる' do
        @item.price = 300
        expect(@item).to be_valid
      end

      it 'priceは9,999,999以下の値(で300以上の値)であれば登録できる' do
        @item.price = 9_999_999
        expect(@item).to be_valid
      end
    end

    context '商品出品できないとき' do
      it 'nameがないと登録できない' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end

      it 'textがないと登録できない' do
        @item.text = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Text can't be blank")
      end

      it 'category_idがないと登録できない' do
        @item.category_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank")
      end

      it 'status_idがないと登録できない' do
        @item.status_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Status can't be blank")
      end

      it 'postage_defrayer_idがないと登録できない' do
        @item.postage_defrayer_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Postage defrayer can't be blank")
      end

      it 'prefecture_idがないと登録できない' do
        @item.prefecture_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture can't be blank")
      end

      it 'day_to_ship_idがないと登録できない' do
        @item.day_to_ship_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Day to ship can't be blank")
      end

      it 'priceがないと登録できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end

      it 'userがないと登録できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("User must exist")
      end

      it 'imageがないと登録できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end

      it 'category_idは半角数字以外は登録できない' do
        @item.category_id = 'a'
        @item.valid?
        expect(@item.errors.full_messages).to include("Category is not a number")
      end

      it 'category_idは1は登録できない' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Category must be other than 1")
      end

      it 'status_idは半角数字以外は登録できない' do
        @item.status_id = 'a'
        @item.valid?
        expect(@item.errors.full_messages).to include("Status is not a number")
      end

      it 'status_idは1は登録できない' do
        @item.status_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Status must be other than 1")
      end

      it 'postage_defrayer_idは半角数字以外は登録できない' do
        @item.postage_defrayer_id = 'a'
        @item.valid?
        expect(@item.errors.full_messages).to include("Postage defrayer is not a number")
      end

      it 'postage_defrayer_idは1は登録できない' do
        @item.postage_defrayer_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Postage defrayer must be other than 1")
      end

      it 'prefecture_idは半角数字以外は登録できない' do
        @item.prefecture_id = 'a'
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture is not a number")
      end

      it 'prefecture_idは1は登録できない' do
        @item.prefecture_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture must be other than 1")
      end

      it 'day_to_ship_idは半角数字以外は登録できない' do
        @item.day_to_ship_id = 'a'
        @item.valid?
        expect(@item.errors.full_messages).to include("Day to ship is not a number")
      end

      it 'day_to_ship_idは1は登録できない' do
        @item.day_to_ship_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Day to ship must be other than 1")
      end

      it 'priceは半角数字以外は登録できない' do
        @item.price = 'a'
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is not a number")
      end

      it 'priceは299以下の値は登録できない' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include("Price must be greater than or equal to 300")
      end

      it 'priceは10,000,000以上の値は登録できない' do
        @item.price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include("Price must be less than or equal to 9999999")
      end
    end
  end
end
