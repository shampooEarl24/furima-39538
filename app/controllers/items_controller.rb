class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  def index
    @items = Item.includes(:user).order('created_at DESC')
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end
  
  def edit
    if @item.user_id == current_user.id
    else
      redirect_to root_path
    end
  end

  def update
    @item.update(item_params)
    if @item.valid?
      redirect_to item_path(item_params)
    else
      render 'edit', status: :unprocessable_entity
    end
  end
  def destroy
    if @item.user_id == current_user.id
      @item.destroy
    end
   #出品者、出品者以外の人もトップページに遷移させることができる
      redirect_to root_path
  end
  private

  def item_params
    params.require(:item).permit(:image, :name, :description, :category_id, :item_status_id, :shipping_cost_id, :delivery_area_id, :shipping_date_id, :price).merge(user_id: current_user.id)
  end
  def set_item
    @item = Item.find(params[:id])
  end
end