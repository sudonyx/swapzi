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

    @items = @items.reject(&:hidden)
    @items = @items.select { |item| item.featured } | @items
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

    user_ach = UserAchievement.new(user: current_user, achievement: Achievement.find_by(name: "Welcome To The Club"))
    flash[:notice] = "Achievement earned: Welcome To The Club" if user_ach.save
  end

  def edit
    @item = Item.find(params[:id])
    authorize @item
  end

  def update
    @item = Item.find(params[:id])
    authorize @item

    @item.update(item_params)
    redirect_to item_path(@item)
  end

  def relist
    @item = Item.find(params[:id])
    authorize @item

    if @item.update(relist: false, hidden: false)
      flash[:notice] = "Item relisted!"
    end

    user_ach = UserAchievement.new(user: current_user, achievement: Achievement.find_by(name: "Non-Stop Swap"))
    flash[:notice] = "Item relisted! Achievement earned: Non-Stop Swap" if user_ach.save

    redirect_to user_profile_path(current_user)
  end

  def feature
    @item = Item.find(params[:id])
    authorize @item

    if current_user.swapzi_score >= 100 && !@item.featured
      if @item.update(featured: true)
        flash[:notice] = "Item featured!"
        current_user.update(swapzi_score: current_user.swapzi_score - 100)
      end
    else
      flash[:notice] = "You don't have enough swapzi points!"
    end

    redirect_to item_path(@item)
  end

  def show
    @item = Item.find(params[:id])
    authorize @item

    @random_items = Item.where(
      'user_id = ? AND id != ?',
      @item.user.id,
      @item.id
    ).order('RANDOM()').limit(4)

    BrowsingHistory.create(user: current_user, item: @item) if user_signed_in?
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :category, :photo)
  end
end
