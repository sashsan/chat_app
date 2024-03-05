# frozen_string_literal: true

class ChatChannel < ApplicationCable::Channel
  def subscribed
    p "Subscribed to #{group.name}"
    stream_for group
  end

  def unsubscribed
    p "Unsubscribed from #{group.name}"
  end

  private

  def group
    @group ||= Group.find(params[:group_id])
  end
end
