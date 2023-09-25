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

    if @conversation.save
      redirect_to conversation_path(@conversation)
    else
      if @conversation.errors[:combo].any?
        @conversation = Conversation.where(user_1: current_user, user_2: User.find(params[:other_user]))
          .or(Conversation.where(user_1: User.find(params[:other_user]), user_2: current_user)).first
        redirect_to conversation_path(@conversation)
      end
    end
  end
end
