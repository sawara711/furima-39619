class ItemsController < ApplicationController
  before_action :move_check, only: [ :new ]
  
  def index
    @items = Item.all.includes(:user).order("created_at DESC")
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(newitem_params)
    if @item.save
      redirect_to root_path
    else
      render 'new', status: :unprocessable_entity
    end
  end

  private
  def newitem_params
    params.require(:item).permit(
      :image, :title, :describe, :category_id, :condition_id, :price,
      :shipping_charge_id, :prefecture_id, :shipping_date_id).merge(user_id: current_user.id)
  end

  def move_check
    if !user_signed_in?
      redirect_to new_user_session_path
    end
  end
  
end
