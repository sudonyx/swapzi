class MessagesController < ApplicationController
  def create
    @conversation = Conversation.find(params[:conversation_id])
    authorize @conversation

    @message = Message.new(message_params)
    authorize @message
    
    @message.conversation = @conversation
    @message.sender = current_user
    
    if @message.save
      ConversationChannel.broadcast_to(
        @conversation,
        render_to_string(partial: "message", locals: {message: @message})
      )
      head :ok
    end

  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
