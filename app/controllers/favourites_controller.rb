class FavouritesController < ApplicationController
    def create
        @item = Item.find(params[:item_id])
        authorize @item

        @favourite = Favourite.new
        authorize @favourite

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
          user_ach = UserAchievement.new(user: current_user, achievement: Achievement.find_by(name: "Swap Lover"))
          flash[:notice] = "Saved as favorite! Achievement earned: Swap Lover" if user_ach.save
        end

        if current_user.favourites.count == 20
          user_ach = UserAchievement.new(user: current_user, achievement: Achievement.find_by(name: "Swap Obsessed"))
          flash[:notice] = "Saved as favorite! Achievement earned: Swap Obsessed" if user_ach.save
        end

        if current_user.favourites.count == 50
          user_ach = UserAchievement.new(user: current_user, achievement: Achievement.find_by(name: "Fav Spammer"))
          flash[:notice] = "Saved as favorite! Achievement earned: Fav Spammer" if user_ach.save
        end
    end

    def destroy
        @favourite = Favourite.find(params[:id])
        @item = @favourite.item

        respond_to do |format|
            if @favourite.destroy
                format.turbo_stream { flash.now[:notice] = "Item unfavourited" }
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
