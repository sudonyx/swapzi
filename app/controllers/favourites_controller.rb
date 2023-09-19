class FavouritesController < ApplicationController
    def create
        @item = Item.find(params[:item_id])
        @favourite = Favourite.new
        @favourite.user = current_user
        @favourite.item = @item
            if @favourite.save
            flash[:notice] = "Saved as favorite!"
            else
            flash[:alert] = "Favorite failed to save."
            end
        redirect_to item_path(@item)
        authorize @item
        authorize @favourite
    end

    def destroy
        @item = Item.find(params[:item_id])
        @favourite = Favourite.find(params[:fav_id])
        if @favourite.destroy
            flash[:notice] = "Item Unfavourited"
        else 
            flash[:notice] = "Error"
        end
        authorize @item
        authorize @favourite
    end
end