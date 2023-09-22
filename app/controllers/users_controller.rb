class UsersController < ApplicationController
    def dashboard
        @user = current_user
        authorize @user
    end

    def swapzi_score
        @user = current_user
        @score = @user.swapzi_score
    end
end
