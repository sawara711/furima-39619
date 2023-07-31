class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # set error message
  error_message_pass = 'is invalid. Include both letters and numbers'
  error_message_fullwidth = 'is invalid. Input full-width characters'
  error_message_kana = 'is invalid. Input full-width katakana characters'
  # set valid
  VALID_PASSWORD_REGEX = /\A(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]+\z/.freeze
  VALID_FULLWIDTH_CHAR = /\A[\p{Han}ぁ-んァ-ヶー]+\z/.freeze
  VALID_FULLWIDTH_CHAR_KANA = /\A[ァ-ヶー]+\z/.freeze
  
  
  # 仮想カラムpasswordが英数字6文字以上となることを検証
  validates :password, format: { with: VALID_PASSWORD_REGEX, message: error_message_pass }

  # 属性が空ではなく全角文字のみ(ー含む)となることを検証
  with_options presence: true,
               format: { with: VALID_FULLWIDTH_CHAR, message: error_message_fullwidth } do
    validates :surname
    validates :givenname
  end

  # 属性が空ではなくカナ文字のみ(ー含む)となることを検証
  with_options presence: true,
               format: { with: VALID_FULLWIDTH_CHAR_KANA, message: error_message_kana } do
    validates :surname_kana
    validates :givenname_kana
  end

  # 属性が空でないことを検証
  with_options presence: true do
    validates :nickname
    validates :birthday
  end
end
