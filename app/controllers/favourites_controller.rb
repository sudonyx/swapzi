class FavouritesController < ApplicationController
    def create
        @item = Item.find(params[:item_id])
        @favourite = Favourite.new
        @favourite.user = current_user
        @favourite.item = @item

        respond_to do |format|
            if @favourite.save
                format.turbo_stream { flash.now[:notice] = "Saved as favorite!" }
                format.turbo_stream { render 'favourites/create', locals: { favourite: @favourite, item: @item }}
            else
                format.turbo_stream { flash.now[:alert] = "Favorite failed to save." }
                format.turbo_stream { render 'favourites/create', locals: { favourite: @favourite, item: @item }}
            end
        end

        if current_user.favourites.count == 5
          ach = Achievement.find_by(name: "Swap Lover")
          user_ach = UserAchievement.new(user: current_user, achievement: ach)
          user_ach.save
          flash[:notice] = "Achievement earned: Swap Lover"
        end

        if current_user.favourites.count == 20
          ach = Achievement.find_by(name: "Swap Obsessed")
          user_ach = UserAchievement.new(user: current_user, achievement: ach)
          user_ach.save
          flash[:notice] = "Achievement earned: Swap Obsessed"
        end

        if current_user.favourites.count == 50
          ach = Achievement.find_by(name: "Fav Spammer")
          user_ach = UserAchievement.new(user: current_user, achievement: ach)
          user_ach.save
          flash[:notice] = "Achievement earned: Fav Spammer"
        end

        # redirect_to item_path(@item)
        authorize @item
        authorize @favourite
    end

    def destroy
        @favourite = Favourite.find(params[:id])
        @item = @favourite.item

        respond_to do |format|
            if @favourite.destroy
                format.turbo_stream { flash.now[:notice] = "Item Unfavourited" }
                format.turbo_stream { render 'favourites/destroy', locals: { favourite: @favourite, item: @item }}
            else
                format.turbo_stream { flash.now[:notice] = "Error" }
                format.turbo_stream { render 'favourites/destroy', locals: { favourite: @favourite, item: @item }}
            end
        end

        # redirect_to item_path(@item)
        authorize @item
        authorize @favourite
    end

    def index
        @favourites = current_user.favourites
        @Favourites = policy_scope(Favourite)
    end
end
