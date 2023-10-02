class UsersController < ApplicationController
  skip_after_action :verify_authorized, only: :profile

  def dashboard
    @achievements = Achievement.all

    @recent_favourites = Favourite.where(user: current_user).order(created_at: :desc).limit(4)
    @recent_items_browsed = BrowsingHistory.where(user: current_user).order(created_at: :desc).limit(4).map(&:item)
    @item_suggestions = Item.where.not(user: current_user).order(created_at: :desc).limit(4)

    authorize @recent_favourites
  end

  def profile
    @user = User.find(params[:user_id])
    authorize @user

    @all_items = Item.where(user: @user, hidden: false)

    @relist_items = Item.where(user: current_user, hidden: true, relist: true)
  end
end
