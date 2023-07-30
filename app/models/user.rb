class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # 仮想カラムpasswordへ英数字6文字以上必須のバリデーションを設定
  VALID_PASSWORD_REGEX = /\A(?=.*?[A-Za-z])(?=.*?\d)[A-Za-z\d]{6,}\z/.freeze
  validates :password, format: { with: VALID_PASSWORD_REGEX, message: '半角英数を両方含む必要があります'}

  # 属性が空でないことを検証
  with_options presence: true do
    validates :nickname
    validates :surname
    validates :givenname
    validates :surname_kana
    validates :givenname_kana
    validates :birthday  
  end
end
