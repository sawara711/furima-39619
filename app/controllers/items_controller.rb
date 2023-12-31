class ItemsController < ApplicationController
  before_action :find_item, only: [ :show, :edit, :update ]
  before_action :authenticate_user!, only: [ :new, :edit, :destroy ]
  before_action :move_to_root, only: [ :edit, :destroy ]
  
  def index
    @items = Item.includes(:order).all.order("created_at DESC")
  end

  def show
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

  def edit
  end

  def update
    if @item.update(newitem_params)
      redirect_to action: :show
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    item = Item.find(params[:id])
    item.destroy
    redirect_to root_path
  end

  private
  def newitem_params
    params.require(:item).permit(
      :image, :title, :describe, :category_id, :condition_id, :price,
      :shipping_charge_id, :prefecture_id, :shipping_date_id).merge(user_id: current_user.id)
  end

  def find_item
    @item = Item.find(params[:id])
  end

  def move_to_root
    if user_signed_in? && Item.find(params[:id]).user_id != current_user.id
      redirect_to root_path
    elsif Order.find_by(item_id: params[:id]).present?
      redirect_to root_path
    end
  end
end
