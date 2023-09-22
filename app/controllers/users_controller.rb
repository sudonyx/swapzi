class UsersController < ApplicationController
    def dashboard
        @user = current_user

        @recent_favourites = Favourite.where(user: @user).order(created_at: :desc).limit(4)
        
        authorize @user
        authorize @recent_favourites
    end

    def swapzi_score
        @user = current_user
        @score = @user.swapzi_score
    end
end
