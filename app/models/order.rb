class Order < ApplicationRecord
  belongs_to :user
  belongs_to :item
  has_one    :delivery, dependent: :destroy
  attr_accessor :token
end
