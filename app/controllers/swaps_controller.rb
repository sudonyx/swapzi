class SwapsController < ApplicationController
  def show
    @swap = Swap.find(params[:id])

    authorize @swap
  end

  def pending
    @show_content = true
    @swaps = Swap.where(user_1: current_user).or(Swap.where(user_2: current_user)).order(created_at: :desc)

    authorize @swaps

    @swaps = @swaps.select { |swap| swap.completed != true }
  end

  def completed
    # @show_content = true
    @swaps = Swap.where(user_1: current_user).or(Swap.where(user_2: current_user)).order(created_at: :desc)

    authorize @swaps
    
    @swaps = @swaps.select { |swap| swap.completed == true }
  end

  def new
    @swap = Swap.new
    @show_item = Item.find(params[:item_id])
    @items = Item.where(user: current_user, hidden: false)

    authorize @swap
    authorize @show_item
    authorize @items
  end

  def create
    @swap = Swap.new(swap_params)

    if @swap.save
      flash[:notice] = "Swap offered"
      redirect_to swaps_path
    else
      flash[:alert] = "This swap already exists!"
      redirect_to item_path(Item.find(params[:swap][:user_1_id] == current_user.id ? params[:swap][:item_1_id] : params[:swap][:item_2_id]))
    end

    authorize @swap
  end

  def update
    @swap = Swap.find(params[:id])

    authorize @swap

    if params.has_key?(:accepted)
      if params[:is_user_1] == "true"
        @swap.update(accepted_user_1: params[:accepted]) if params.has_key?(:accepted)
      else
        @swap.update(accepted_user_2: params[:accepted]) if params.has_key?(:accepted)
      end
    end
    
    if params.has_key?(:completed) && both_users_accepted?
      if params[:is_user_1] == "true"
        @swap.update(completed_user_1: params[:completed])
      else
        @swap.update(completed_user_2: params[:completed])
      end

      if both_users_completed?
        @swap.update(completed: true)
        update_swapzi_score_both_users
        update_swap_counter_for_both_items

        @swap.item_1.update(hidden: true)
        @swap.item_2.update(hidden: true)

        @swaps = Swap.where(item_1: @swap.item_1).or(Swap.where(item_2: @swap.item_1)).or(Swap.where(item_1: @swap.item_2)).or(Swap.where(item_2: @swap.item_2))
        @swaps.each { |swap| swap.destroy }

        create_duplicate_items_and_swap_users
  
        redirect_to dashboard_path and return
      end
    elsif params.has_key?(:completed)
      if @swap.item_1.user == current_user && @swap.accepted_user_2 != true || @swap.item_2.user == current_user && @swap.accepted_user_1 != true
        flash[:notice] = "Other user has not accepted"
      else
        flash[:notice] = "You have not accepted the swap"
      end
    end

    redirect_to swap_path(@swap)
  end

  def destroy
    @swap = Swap.find(params[:id])
    authorize @swap

    unless @swap.item_1.user == current_user || @swap.item_2.user == current_user
      flash[:alert] = "Error: Swap does not belong to you"
      redirect_to dashboard_path and return
    end

    if @swap.completed
      flash[:alert] = "Cannnot cancel a completed swap!"
      redirect_to swap_path(@swap) and return
    elsif both_users_accepted?
      @swap.item_1.user == current_user ? @swap.item_1.user.update(swapzi_score: @swap.item_1.user.swapzi_score - 100) : @swap.item_2.user.update(swapzi_score: @swap.item_2.user.swapzi_score - 100)
      @swap.destroy
      flash[:alert] = "100 Swapzi points deducted! :("
      redirect_to dashboard_path and return
    else
      @swap.destroy
    end

    redirect_to swaps_path
  end

  private

  def swap_params
    params.require(:swap).permit(:item_1_id, :user_1_id, :accepted_user_1, :item_2_id, :user_2_id)
  end

  def both_users_accepted?
    @swap.accepted_user_1 && @swap.accepted_user_2
  end

  def both_users_completed?
    @swap.completed_user_1 && @swap.completed_user_2
  end

  def update_swap_counter_for_both_items
    unless @swap.item_1.swap_counter == nil
      @swap.item_1.update(swap_counter: @swap.item_1.swap_counter + 1)
    else
      @swap.item_1.update(swap_counter: 1)
    end
    unless @swap.item_2.swap_counter == nil
      @swap.item_2.update(swap_counter: @swap.item_2.swap_counter + 1)
    else
      @swap.item_2.update(swap_counter: 1)
    end
  end

  def create_duplicate_items_and_swap_users
    name = @swap.item_1.name
    description = @swap.item_1.description
    category = @swap.item_1.category
    swapzi_points = @swap.item_1.swapzi_points
    user = @swap.item_1.user
    swap_counter = @swap.item_1.swap_counter
    hidden = true
    @item = Item.new(name:, description:, category:, swapzi_points:, swap_counter:, hidden:)
    @item.user = @swap.item_2.user
    @item.photo.attach(io: StringIO.new(@swap.item_1.photo.download), filename: @item.name, content_type: @swap.item_1.photo.content_type)
    @item.save

    name = @swap.item_2.name
    description = @swap.item_2.description
    category = @swap.item_2.category
    swapzi_points = @swap.item_2.swapzi_points
    user = @swap.item_2.user
    swap_counter = @swap.item_2.swap_counter
    hidden = true
    @item = Item.new(name:, description:, category:, swapzi_points:, swap_counter:, hidden:)
    @item.user = @swap.item_1.user
    @item.photo.attach(io: StringIO.new(@swap.item_2.photo.download), filename: @item.name, content_type: @swap.item_2.photo.content_type)
    @item.save
  end

  def update_swapzi_score_both_users
    if @swap.item_1.user == current_user
      points_earned = @swap.item_2.swapzi_points
      current_user.update!(swapzi_score: current_user.swapzi_score + points_earned)
      @swap.item_2.user.update!(swapzi_score: @swap.item_2.user.swapzi_score + @swap.item_1.swapzi_points)
    else
      points_earned = @swap.item_1.swapzi_points
      current_user.update!(swapzi_score: current_user.swapzi_score + points_earned)
      @swap.item_1.user.update!(swapzi_score: @swap.item_1.user.swapzi_score + @swap.item_2.swapzi_points)
    end
    flash[:notice] = "You earned #{points_earned} Swapzi points!"
  end
end
