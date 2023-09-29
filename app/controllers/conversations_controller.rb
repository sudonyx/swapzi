class ConversationsController < ApplicationController
  def index
    @conversations = policy_scope(Conversation)

    unless @conversations.empty?
      redirect_to conversation_path(@conversations.first)
    end
  end

  def show
    @conversations = policy_scope(Conversation)

    @conversation = @conversations.find(params[:id])
    @message = Message.new

    authorize @conversation
    authorize @message
  end

  def create
    @conversation = Conversation.new(user_1: current_user, user_2: User.find(params[:other_user]))
    authorize @conversation

    swap = Swap.find(params[:swap])
    item_1 = swap.item_1.user == current_user ? swap.item_1 : swap.item_2
    item_2 = swap.item_1.user == current_user ? swap.item_2 : swap.item_1


    if @conversation.save
      message = Message.new(content: "Hi #{item_2.user.username}. I'm interested in swapping my #{item_1.name} for your #{item_2.name}.(swap_id=#{swap.id})")
      message.conversation = @conversation
      message.sender = current_user
      message.save!
    elsif @conversation.errors[:combo].any?
      @conversation = Conversation.where(user_1: current_user, user_2: User.find(params[:other_user]))
        .or(Conversation.where(user_1: User.find(params[:other_user]), user_2: current_user)).first
      default_message_for_this_swap = @conversation.messages.select do |message|
        pattern = /\(swap_id=(\d+)\)\z/
        if pattern.match(message.content)
          match_data = pattern.match(message.content)
          match_data[1].to_i == swap.id
        end
      end

      if default_message_for_this_swap.empty?
        message = Message.new(content: "Hi #{item_2.user.username}. I'm interested in swapping my #{item_1.name} for your #{item_2.name}.(swap_id=#{swap.id})")
        message.conversation = @conversation
        message.sender = current_user
        message.save!
      end
    end

    redirect_to conversation_path(@conversation)
  end
end
