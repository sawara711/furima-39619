class OrderDelivery
  # ActiveRecordを継承
  include ActiveModel::Model
  attr_accessor :item_id, :user_id, :postcode, :prefecture_id,
                :city, :address, :building, :phonenumber, :order_id,
                :token

  # set error message
  error_message_blank = "can't be blank"
  error_message_postcode = "is invalid. Enter it as follows (e.g. 123-4567)"
  error_message_number = "is invalid. Input only number"
  error_message_short = "is too short (message for short length)"
  error_message_long = "is too long (message for long length)"

  # set valid
  VALID_POSTCODE = /\A[0-9]{3}[-][0-9]{4}\z/.freeze

  # 属性が空でないことを検証
  with_options presence: true do
    validates :token
    validates :item_id
    validates :user_id
    # 郵便番号形式(xxx-xxxx)の数字となることを検証
    validates :postcode, format: { with: VALID_POSTCODE, message: error_message_postcode }
    validates :city
    validates :address
    # 桁数が指定範囲内且つ、半角数字のみであることを検証
    validates :phonenumber,
      numericality: { only_integer: true, message: error_message_number },
      length: { minimum: 10, maximum: 11, too_short: error_message_short }
    end
  # 属性が2~48であることを検証
  validates :prefecture_id, inclusion: { in: 2..48, message: error_message_blank }


  def save
    order = Order.create(item_id: item_id, user_id: user_id, token: token)
    Delivery.create(postcode: postcode, prefecture_id: prefecture_id, city: city, address: address,
                    building: building, phonenumber: phonenumber, order_id: order.id)
  end
end