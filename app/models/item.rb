class Item < ApplicationRecord
  # association
  belongs_to :user
  # ActiveStorage association
  has_one_attached :image

  # activehash association
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :prefecture
  belongs_to :shipping_charge
  belongs_to :shipping_date

  # set error message
  error_message_halfwidth = 'is invalid. Input half-width characters'
  error_message_range = 'is out of setting range'
  error_message_blank = "can't be blank"

  # 属性が空でないことを検証
  with_options presence: true do
    # ActiveStorage
    validates :image
    validates :title
    validates :describe
    # 属性が指定の範囲内且つ、半角数字のみであることを検証
    validates :price,
      numericality: { only_integer: true, message: error_message_halfwidth },
      inclusion: { in: 300..9_999_999, message: error_message_range }
  end

  # 属性が1以外であることを検証
  with_options exclusion: { in: [1], message: error_message_blank } do
    validates :category_id
    validates :condition_id
    validates :shipping_charge_id
    validates :prefecture_id
    validates :shipping_date_id
  end

end
