class SwapsController < ApplicationController
  def show
    @swap = Swap.find(params[:id])

    authorize @swap
  end

  def new
    @swap = Swap.new
    @show_item = Item.find(params[:item_id])
    @user_items = Item.where(user: current_user)

    authorize @swap
    authorize @show_item
    authorize @user_items
  end

  def create
    @swap = Swap.new(swap_params)

    if @swap.save
      flash[:notice] = "Swap offered"
      redirect_to swap_path(@swap)
    else
      render :new, status: :unprocessable_entity
    end

    authorize @swap
  end

  private

  def swap_params
    params.require(:swap).permit(:item_1_id, :user_1_id, :item_2_id, :user_2_id)
  end
end
