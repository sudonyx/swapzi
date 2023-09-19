class ItemsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index ]
  
  def index
    @items = Item.all

    @items = policy_scope(Item)
  end
  
  def new
    @item = Item.new
    authorize @item
  end

  def create
    @item = Item.new(item_params)
    authorize @item
    @item.user = current_user
    @item.swapzi_points = 100
    if @item.save
      redirect_to item_path(@item)
    else
      render :new, status: :unprocessable_entity
    end
  end
  
  def show
    @item = Item.find(params[:id])
    @user = current_user
    authorize @item
    authorize @user
    @random_items = Item.order("RANDOM()").limit(3)
  end 
  
  private

  def item_params
    params.require(:item).permit(:name, :description, :category)
  end
end
