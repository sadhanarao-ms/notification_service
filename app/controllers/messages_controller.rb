class MessagesController < ApplicationController

  def push
    message = Message.last
    title = message&.title || ''
    msg = message&.message || ''
    message&.destroy
    render json: { title: title, message: msg }
  end
end
