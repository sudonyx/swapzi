class SwapsController < ApplicationController
  def show
    @swap = Swap.find(params[:id])

    authorize @swap
  end

  def pending
    @show_content = true
    @swaps = Swap.where(user_1: current_user).or(Swap.where(user_2: current_user)).order(created_at: :desc)

    authorize @swaps

    @swaps = @swaps.select { |swap| swap.completed != true }
  end

  def completed
    # @show_content = true
    @swaps = Swap.where(user_1: current_user).or(Swap.where(user_2: current_user)).order(created_at: :desc)

    authorize @swaps

    @swaps = @swaps.select { |swap| swap.completed == true }
  end

  def new
    @swap = Swap.new
    @show_item = Item.find(params[:item_id])
    @items = policy_scope(Item)
    @items = @items.select { |item| item.user == current_user }

    authorize @swap
    authorize @show_item
  end

  def create
    @swap = Swap.new(swap_params)

    if @swap.save
      flash[:notice] = "Swap offered"
      redirect_to swaps_path
    else
      flash[:alert] = "This swap already exists!"
      redirect_to item_path(Item.find(params[:swap][:user_1_id] == current_user.id ? params[:swap][:item_1_id] : params[:swap][:item_2_id]))
    end

    authorize @swap
  end

  def update
    @swap = Swap.find(params[:id])

    authorize @swap

    if params.has_key?(:accepted)
      if params[:is_user_1] == "true"
        @swap.update(accepted_user_1: params[:accepted]) if params.has_key?(:accepted)
      else
        @swap.update(accepted_user_2: params[:accepted]) if params.has_key?(:accepted)
      end

      if both_users_accepted?
        @swaps = Swap.where(item_1: @swap.item_1).or(Swap.where(item_2: @swap.item_1)).or(Swap.where(item_1: @swap.item_2)).or(Swap.where(item_2: @swap.item_2))
        @swaps = @swaps.select { |swap| swap.id != @swap.id }
        @swaps.each do |swap|
          users = [swap.item_1.user, swap.item_2.user]
          users.each do |user|
            convo = Conversation.new(user_1: User.find_by(email: "admin@swapzi.site"), user_2: user)
            unless convo.save
              convo = Conversation.find_by(user_1: User.find_by(email: "admin@swapzi.site"), user_2: user)
            end
            message = Message.new(sender: User.find_by(email: "admin@swapzi.site"), content: "Swap cancelled (item accepted in different swap): #{swap.item_1.name} for #{swap.item_2.name}")
            message.conversation = convo
            message.save!
          end
          swap.destroy
        end

        @swap.item_1.update(hidden: true)
        @swap.item_2.update(hidden: true)
      end
    end

    if params.has_key?(:completed) && both_users_accepted?
      if params[:is_user_1] == "true"
        @swap.update(completed_user_1: params[:completed])
      else
        @swap.update(completed_user_2: params[:completed])
      end

      if both_users_completed?
        @swap.update(completed: true)
        update_swapzi_score_both_users
        update_swap_counter_for_both_items_and_users
        give_achievements

        @swap.item_1.update(hidden: true)
        @swap.item_2.update(hidden: true)

        create_duplicate_items_and_swap_users

        redirect_to dashboard_path and return
      end
    elsif params.has_key?(:completed)
      if @swap.item_1.user == current_user && @swap.accepted_user_2 != true || @swap.item_2.user == current_user && @swap.accepted_user_1 != true
        flash[:notice] = "Other user has not accepted"
      else
        flash[:notice] = "You have not accepted the swap"
      end
    end

    redirect_to swap_path(@swap)
  end

  def destroy
    @swap = Swap.find(params[:id])
    authorize @swap

    unless @swap.item_1.user == current_user || @swap.item_2.user == current_user
      flash[:alert] = "Error: Swap does not belong to you"
      redirect_to dashboard_path and return
    end

    if @swap.completed
      flash[:alert] = "Cannnot cancel a completed swap!"
      redirect_to swap_path(@swap) and return
    elsif both_users_accepted?
      @swap.item_1.user == current_user ? @swap.item_1.user.update(swapzi_score: @swap.item_1.user.swapzi_score - 100) : @swap.item_2.user.update(swapzi_score: @swap.item_2.user.swapzi_score - 100)
      @swap.destroy

      @swap.item_1.update(hidden: false)
      @swap.item_2.update(hidden: false)
      flash[:alert] = "100 Swapzi points deducted! :("
      redirect_to dashboard_path and return
    else
      @swap.destroy
    end

    redirect_to swaps_path
  end

  private

  def swap_params
    params.require(:swap).permit(:item_1_id, :user_1_id, :accepted_user_1, :item_2_id, :user_2_id)
  end

  def both_users_accepted?
    @swap.accepted_user_1 && @swap.accepted_user_2
  end

  def both_users_completed?
    @swap.completed_user_1 && @swap.completed_user_2
  end

  def update_swap_counter_for_both_items_and_users
    @swap.item_1.update(swap_counter: @swap.item_1.swap_counter + 1)
    @swap.item_2.update(swap_counter: @swap.item_2.swap_counter + 1)
    @swap.item_1.user.update(swapz_count: @swap.item_1.user.swapz_count + 1)
    @swap.item_2.user.update(swapz_count: @swap.item_2.user.swapz_count + 1)
  end

  def create_duplicate_items_and_swap_users
    items = [@swap.item_1, @swap.item_2]
    items.each do |item|
      new_item = Item.new(name: item.name, description: item.description, category: item.category, swapzi_points: item.swapzi_points, swap_counter: item.swap_counter, hidden: true, relist: true)
      new_item.user = item == @swap.item_1 ? @swap.item_2.user : @swap.item_1.user
      new_item.photo.attach(io: StringIO.new(item.photo.download), filename: item.name, content_type: item.photo.content_type)
      new_item.save
    end
  end

  def update_swapzi_score_both_users
    @swap.item_1.user.update!(swapzi_score: @swap.item_1.user.swapzi_score + @swap.item_2.swapzi_points)
    @swap.item_2.user.update!(swapzi_score: @swap.item_2.user.swapzi_score + @swap.item_1.swapzi_points)

    flash[:notice] = "Swap complete! You earned #{@swap.item_1.user == current_user ? @swap.item_2.swapzi_points : @swap.item_1.swapzi_points} Swapzi points"
  end

  def give_achievements
    users = [@swap.item_1.user, @swap.item_2.user]
    users.each do |user|
      if user.swapz_count == 1
        user_ach = UserAchievement.new(user: user, achievement: Achievement.find_by(name: "Swap Rookie"))
        flash[:notice] = "Achievement earned: Swap Rookie" if user_ach.save && user == current_user
      end

      if user.swapz_count == 5
        user_ach = UserAchievement.new(user: user, achievement: Achievement.find_by(name: "Seasoned Swapper"))
        flash[:notice] = "Achievement earned: Seasoned Swapper" if user_ach.save && user == current_user
      end

      if user.swapz_count == 20
        user_ach = UserAchievement.new(user: user, achievement: Achievement.find_by(name: "Swap Master"))
        flash[:notice] = "Achievement earned: Swap Master" if user_ach.save && user == current_user
      end

      if @swap.item_1.swap_counter >= 10 || @swap.item_2.swap_counter >= 10
        user_ach = UserAchievement.new(user: user, achievement: Achievement.find_by(name: "Swap Til' You Drop"))
        flash[:notice] = "Achievement earned: Swap Til' You Drop" if user_ach.save && user == current_user
      end

      if @swap.updated_at.hour >= 22 || @swap.updated_at.hour <= 4
        user_ach = UserAchievement.new(user: user, achievement: Achievement.find_by(name: "Night Owl"))
        flash[:notice] = "Achievement earned: Night Owl" if user_ach.save && user == current_user
      end
    end
  end
end
