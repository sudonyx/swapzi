class ItemsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index ]
  
  def index
    @items = policy_scope(Item)

    if params[:query].present?
      @items = Item.search_by_name_and_description(params[:query])
      header_prefix = "Search results"
    else
      header_prefix = "All items"
    end

    if params[:category].present? && params[:category] != "all categories"
      @items = @items.select { |item| item.category == params[:category] }
      @header = "#{header_prefix} in #{params[:category].downcase}"
      @selected = params[:category]
    else
      @header = header_prefix
      @selected = "all categories"
    end
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
    @item.swap_counter = 0
    if @item.save
      redirect_to item_path(@item)
    else
      render :new, status: :unprocessable_entity
    end
  end
  
  def show
    @item = Item.find(params[:id])
    authorize @item
    @random_items = Item.where(user: @item.user).order("RANDOM()").limit(4)
  end 
  
  private

  def item_params
    params.require(:item).permit(:name, :description, :category, :photo)
  end
end
