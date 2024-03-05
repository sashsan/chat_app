# frozen_string_literal: true

class MessagesController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]
  before_action :authenticate_user!

  def index
    @messages = current_user.messages
  end

  def create
    group = Group.find(params[:group_id])
    message = current_user.messages.build(message_params)

    if message.save
      ChatChannel.broadcast_to(group, render_message(message))
      head :no_content
    else
      flash[:alert] = 'Не удалось отправить сообщение.'
      redirect_to group_path group
    end
  end

  private

  def message_params
    params.require(:message)
          .permit(:content)
          .merge(group_id: params[:group_id])
  end

  def render_message(mes)
    ApplicationController
      .renderer
      .render(partial: 'messages/message', locals: { message: mes })
  end
end
