class UsersController < ApplicationController
    def dashboard
        @recent_favourites = Favourite.where(user: current_user).order(created_at: :desc).limit(4)

        @item_suggestions = Item.where.not(user: current_user).order(created_at: :desc).limit(4)
        
        authorize @recent_favourites
    end
end
