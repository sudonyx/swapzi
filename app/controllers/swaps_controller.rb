class SwapsController < ApplicationController
  def show
    @swap = Swap.find(params[:id])
    @user = current_user

    authorize @swap
    authorize @user
  end

  def pending
    @user = current_user
    @swaps = Swap.where(user_1: @user).or(Swap.where(user_2: @user)).order(created_at: :desc)

    authorize @user
    authorize @swaps
  end

  def new
    @swap = Swap.new
    @show_item = Item.find(params[:item_id])
    @items = Item.where(user: current_user)

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
      render :new, status: :unprocessable_entity
    end

    authorize @swap
  end

  def update
    @swap = Swap.find(params[:id])

    if params.has_key?(:accepted)
      if params[:is_user_1] == true
        redirect if @swap.update(accepted_user_1: params[:accepted]) if params.has_key?(:accepted)
      else
        redirect if @swap.update(accepted_user_2: params[:accepted]) if params.has_key?(:accepted)
      end
    end
    
    if params.has_key?(:completed) && both_users_accepted?
      if params[:is_user_1] == true
        @swap.update(completed_user_1: params[:completed])
      else
        @swap.update(completed_user_2: params[:completed])
      end
    end

    if both_users_completed?
      @swap.update(completed: true)
    end

    authorize @swap
  end

  def destroy
    @swap = Swap.find(params[:id])

    @swap.destroy if @swap.user_1 == current_user || @swap.user_2 == current_user
    redirect_to swaps_path

    authorize @swap
  end

  private

  def swap_params
    params.require(:swap).permit(:item_1_id, :user_1_id, :accepted_user_1, :item_2_id, :user_2_id)
  end

  def both_users_accepted?
    @swap.accepted_user_1 == true && @swap.accepted_user_2 == true
  end

  def both_users_completed?
    @swap.completed_user_1 == true && @swap.completed_user_2 == true
  end

  def redirect
    redirect_to swaps_path if params[:origin] == "swap_pending"
    redirect_to swap_path(@swap) if params[:origin] == "swap_show"
  end
end
