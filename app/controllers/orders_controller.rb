class OrdersController < ApplicationController
  before_action :find_item, only: [ :index, :create ]
  before_action :authenticate_user!, only: [ :index ]
  before_action :move_to_root, only: [ :index ]

  def index
    gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
    @order = OrderDelivery.new
  end

  def create
    gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
    @order = OrderDelivery.new(order_params)
    if @order.valid?
      ActiveRecord::Base.transaction do
        pay_item
        @order.save
      end
      redirect_to root_path
    else
      render :index, status: :unprocessable_entity
    end
  end

  private
  def order_params
    prefecture_id = params[:order_delivery][:prefecture_id].to_i
    params.require(:order_delivery).permit(
      #:postcode, :prefecture_id, :city, :address, :building, :phonenumber).merge(
      :postcode, :city, :address, :building, :phonenumber).merge(
      user_id: current_user.id, item_id: params[:item_id], token: params[:token], prefecture_id: prefecture_id)
  end

  def find_item
    @item = Item.find(params[:item_id])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item.price,
      card: order_params[:token],
      currency: 'jpy'
    )
  end

  def move_to_root
    if Order.find_by(item_id: params[:item_id]).present?
      redirect_to root_path
    elsif Item.find(params[:item_id]).user_id == current_user.id
      redirect_to root_path
    end
  end

end
