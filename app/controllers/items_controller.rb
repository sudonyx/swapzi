class ItemsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index ]

  def index
    @items = Item.all

    @items = policy_scope(Item)
  end

  def show
    @item = Item.find(params[:id])
    authorize @item
    @random_items = Item.order("RANDOM()").limit(3)
  end 
end
