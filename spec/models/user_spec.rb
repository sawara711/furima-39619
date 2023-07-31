require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  # モデルのテストのため、新規登録のみで確認する
  describe 'ユーザー新規登録' do
    context '新規登録できるとき' do
      # 正常系
      it 'nickname/email/password/surname/surname_kana/givenname/givenname_kana/birthdayが存在すれば登録できる' do
        expect(@user).to be_valid
      end
    end
    context '新規登録できないとき' do
      # 異常系
      it 'nicknameが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it '重複したemailが存在する場合は登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end
      it 'emailは@を含まないと登録できない' do
        @user.email = "email"
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end
      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'passwordが5文字以下では登録できない' do
        @user.password = '111'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
      end
      it 'passwordが半角英字のみだと登録できない' do
        @user.password = 'AAaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid. Include both letters and numbers")
      end
      it 'passwordが半角数字のみだと登録できない' do
        @user.password = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid. Include both letters and numbers")
      end
      it 'passwordとpassword_confirmationが不一致では登録できない' do
        @user.password = '123456'
        @user.password_confirmation = '1234567'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      # 一括りで設定をしているため片方のみ確認する
      it 'surnameまたはgivennameが空では登録できない' do
        @user.surname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Surname can't be blank")
      end
      it 'surnameまたはgivennameが半角文字では登録できない' do
        @user.givenname = 'ciao'
        @user.valid?
        expect(@user.errors.full_messages).to include("Givenname is invalid. Input full-width characters")
      end
      it 'surname_kanaまたはgivenname_kanaが空では登録できない' do
        @user.surname_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Surname kana can't be blank")
      end
      it 'surname_kanaまたはgivenname_kanaがカナ文字以外では登録できない' do
        @user.givenname_kana = 'おちゃ'
        @user.valid?
        expect(@user.errors.full_messages).to include("Givenname kana is invalid. Input full-width katakana characters")
      end
      it 'birthdayが空では登録できない' do
        @user.birthday = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end
    end
  end
end