class NotificationsController < ApplicationController
  def index
 
    @unread_messages_count = current_user.messages.where(read: false).count

    pattern = /\(swap_id=(\d+)\)\z/
    @pending_swaps = current_user.messages.where("content LIKE ?", "%#{pattern}%").where(read: false)

    @latest_messages = current_user.messages.order(created_at: :desc).limit(2)
  end
end
