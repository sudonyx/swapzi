class UsersController < ApplicationController
  skip_after_action :verify_authorized, only: :profile

  def dashboard
    @achievements = Achievement.all

    @open_swaps = Swap.where(user_1: current_user).or(Swap.where(user_2: current_user))
    @new_swaps = @open_swaps.select do |swap|
      swap.user_1 == current_user && swap.accepted_user_1 != true || swap.user_2 == current_user && swap.accepted_user_2 != true
    end

    @recent_favourites = Favourite.where(user: current_user).order(created_at: :desc).limit(4)
    @recent_items_browsed = BrowsingHistory.where(user: current_user).order(created_at: :desc).limit(4).map(&:item)

    @recent_items_browsed = @recent_items_browsed.select { |item| item.hidden == false && item.user != current_user }

    @item_suggestions = Item.where.not(user: current_user).order("RANDOM()")
    @item_suggestions = @item_suggestions.select { |item| item.featured } | @item_suggestions
    @item_suggestions = @item_suggestions.select { |item| item.hidden == false }.first(4)

    authorize @recent_favourites
  end

  def profile
    @user = User.find(params[:user_id])
    authorize @user

    @all_items = Item.where(user: @user, hidden: false)

    @relist_items = Item.where(user: current_user, hidden: true, relist: true).order(created_at: :desc)
  end
end
