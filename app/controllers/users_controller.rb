class UsersController < ApplicationController
  class UsersController < ApplicationController
    before_action :authenticate_user!, except: [:show]
    before_action :set_user, only: [:show, :edit, :update]

    def show
    end

    def edit
      authorize @user
    end

    def update
      authorize @user

      if @user.update(user_profile_params)
        redirect_to user_profile_path(@user), notice: 'Profile updated successfully.'
      else
        render :edit
      end
    end

    private

    def set_user
      @user = User.find(params[:id])
    end

    def user_profile_params
      params.require(:user).permit(:username, :location, :email, :swapzi_score)
    end
  end
end
