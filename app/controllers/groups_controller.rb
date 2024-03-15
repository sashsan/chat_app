# frozen_string_literal: true

class GroupsController < ApplicationController
  before_action :authenticate_user!

  def index
    @groups = Group.except_private
  end

  def show
    group_type = params[:group_chat] ? :public_chat : :private_chat
    @recipient = User.find_by(id: params[:recipient_id])

    @group = ::Groups::GroupFactory.call(id: params[:id], recipient: @recipient,
                                         user: current_user, type: group_type)

    @messages = @group.messages.includes(:user).order(:created_at)
  end

  def create
    @group = Group.new(group_params)

    if @group.save
      flash[:success] = 'Группа успешно создана'
    else
      flash[:alert] = 'Не удалось создать группу'
    end
    redirect_to root_path
  end

  private

  def group_params
    params.require(:group).permit(:name)
  end
end
