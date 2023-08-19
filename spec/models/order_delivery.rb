require 'rails_helper'

RSpec.describe OrderDelivery, type: :model do
  before do
    @item = FactoryBot.create(:item)
    @order = FactoryBot.build(:order_delivery, item_id: @item.id, user_id: @item.user.id)
  end

  describe '商品購入' do
    context '購入できる場合' do
      # 正常系
      it '配送先情報とtokenがあれば保存ができること' do
        expect(@order).to be_valid
      end
    end

    context '購入できない場合' do
      # 異常系
      it 'tokenが空では登録できないこと' do
        @order.token = nil
        @order.valid?
        expect(@order.errors.full_messages).to include("Token can't be blank")
      end
      it 'postcodeが空では登録できない' do
        @order.postcode = ''
        @order.valid?
        expect(@order.errors.full_messages).to include("Postcode can't be blank")
      end
      it 'postcodeが全角文字では登録できない' do
        @order.postcode = 'ちゃ'
        @order.valid?
        expect(@order.errors.full_messages).to include("Postcode is invalid. Enter it as follows (e.g. 123-4567)")
      end
      it 'postcodeが全角数字では登録できない' do
        @order.postcode = '１２３-００７７'
        @order.valid?
        expect(@order.errors.full_messages).to include("Postcode is invalid. Enter it as follows (e.g. 123-4567)")
      end
      it 'postcodeがフォーマットと異なる半角数字では登録できない' do
        @order.postcode = '1231233'
        @order.valid?
        expect(@order.errors.full_messages).to include("Postcode is invalid. Enter it as follows (e.g. 123-4567)")
      end
      it 'cityが空では登録できない' do
        @order.city = ''
        @order.valid?
        expect(@order.errors.full_messages).to include("City can't be blank")
      end
      it 'addressが空では登録できない' do
        @order.address = ''
        @order.valid?
        expect(@order.errors.full_messages).to include("Address can't be blank")
      end
      it 'phonenumberが空では登録できない' do
        @order.phonenumber = ''
        @order.valid?
        expect(@order.errors.full_messages).to include("Phonenumber can't be blank")
      end
      it 'phonenumberが全角文字では登録できない' do
        @order.phonenumber = 'あいう'
        @order.valid?
        expect(@order.errors.full_messages).to include("Phonenumber is invalid. Input only number")
      end
      it 'phonenumberが全角数字では登録できない' do
        @order.phonenumber = '１２３４５６７８９０'
        @order.valid?
        expect(@order.errors.full_messages).to include("Phonenumber is invalid. Input only number")
      end
      it 'phonenumberが半角文字では登録できない' do
        @order.phonenumber = 'asdfghjklp'
        @order.valid?
        expect(@order.errors.full_messages).to include("Phonenumber is invalid. Input only number")
      end
      it 'phonenumberが9文字以下では登録できない' do
        @order.phonenumber = 123
        @order.valid?
        expect(@order.errors.full_messages).to include("Phonenumber is too short (message for short length)")
      end
      it '発送元の地域が「---」では登録できない' do
        @order.prefecture_id = 1
        @order.valid?
        expect(@order.errors.full_messages).to include("Prefecture can't be blank")
      end
      it 'ユーザーが紐づいていなければ登録できない' do
        @order.user_id = nil
        @order.valid?
        expect(@order.errors.full_messages).to include("User can't be blank")
      end
      it '商品が紐づいていなければ登録できない' do
        @order.item_id = nil
        @order.valid?
        expect(@order.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end