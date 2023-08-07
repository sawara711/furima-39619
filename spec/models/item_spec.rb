require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

    describe '商品出品' do
      context '出品できるとき' do
        # 正常系
        it '属性が空ではなければ出品できる' do
          expect(@item).to be_valid
        end
      end
      context '出品できないとき' do
        # 異常系
        it '画像が空では登録できない' do
          @item.image = nil
          @item.valid?
          expect(@item.errors.full_messages).to include("Image can't be blank")
        end
        it '商品名が空では登録できない' do
          @item.title = ''
          @item.valid?
          expect(@item.errors.full_messages).to include("Title can't be blank")
        end
        it '商品の説明が空では登録できない' do
          @item.describe = ''
          @item.valid?
          expect(@item.errors.full_messages).to include("Describe can't be blank")
        end
        it 'カテゴリーが「---」では登録できない' do
          @item.category_id = 1
          @item.valid?
          expect(@item.errors.full_messages).to include("Category can't be blank")
        end
        it '商品の状態が「---」では登録できない' do
          @item.condition_id = 1
          @item.valid?
          expect(@item.errors.full_messages).to include("Condition can't be blank")
        end
        it '配送料の負担が「---」では登録できない' do
          @item.shipping_charge_id = 1
          @item.valid?
          expect(@item.errors.full_messages).to include("Shipping charge can't be blank")
        end
        it '発送元の地域が「---」では登録できない' do
          @item.prefecture_id = 1
          @item.valid?
          expect(@item.errors.full_messages).to include("Prefecture can't be blank")
        end
        it '発送までの日数が「---」では登録できない' do
          @item.shipping_date_id = 1
          @item.valid?
          expect(@item.errors.full_messages).to include("Shipping date can't be blank")
        end
        it '販売価格が空では登録できない' do
          @item.price = nil
          @item.valid?
          expect(@item.errors.full_messages).to include("Price can't be blank")
        end
        it '販売価格が全角数字では登録できない' do
          @item.price = '３０００'
          @item.valid?
          expect(@item.errors.full_messages).to include("Price is invalid. Input half-width characters")
        end
        it '販売価格が全角文字では登録できない' do
          @item.price = 'あいう'
          @item.valid?
          expect(@item.errors.full_messages).to include("Price is invalid. Input half-width characters")
        end
        it '販売価格が半角文字では登録できない' do
          @item.price = 'char'
          @item.valid?
          expect(@item.errors.full_messages).to include("Price is invalid. Input half-width characters")
        end
        it '販売価格が300より小さい値であれば登録できない' do
          @item.price = 100
          @item.valid?
          expect(@item.errors.full_messages).to include("Price is out of setting range")
        end
        it '販売価格9999999より大きい値であれば登録できない' do
          @item.price = 100000000
          @item.valid?
          expect(@item.errors.full_messages).to include("Price is out of setting range")
        end
        it 'ユーザーが紐づいていいなければ登録できない' do
          @item.user = nil
          @item.valid?
          expect(@item.errors.full_messages).to include("User must exist")
        end
      end
    end
end





