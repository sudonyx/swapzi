class FavouritesController < ApplicationController
    def create
        item = Item.find(params[:item_id])
        authorize item
        favourite = current_user.favourites.build(item: item)
        authorize favourite
        if favourite.save
        flash[:notice] = "Saved as favorite!"
        else
        flash[:alert] = "Favorite failed to save."
        end
        redirect_to item_path(item)
    end
    
    def destroy
        item = Item.find(params[:item_id])
        authorize item
        favourite = current_user.favourites.find(params[:id])
        authorize favourite
        if favourite.destroy
            flash[:notice] = "Item Unfavourited"
        else 
            flash[:notice] = "Error"
        end
    end
end