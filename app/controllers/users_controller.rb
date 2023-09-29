class UsersController < ApplicationController
  skip_after_action :verify_authorized, only: :profile

  def dashboard
    @relist_items = Item.where(user: current_user, hidden: true, relist: true)
    authorize @relist_items

    @recent_favourites = Favourite.where(user: current_user).order(created_at: :desc).limit(4)
    @recent_items_browsed = BrowsingHistory.where(user: current_user).order(created_at: :desc).limit(4).map(&:item)
    @item_suggestions = Item.where.not(user: current_user).order(created_at: :desc).limit(4)

    authorize @recent_favourites
  end

  def profile
    @all_items = Item.where(user: current_user)
  end
end
