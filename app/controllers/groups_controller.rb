# frozen_string_literal: true

class GroupsController < ApplicationController
  before_action :authenticate_user!

  def index
    @groups = Group.except_private
  end

  def show
    if params[:group_chat]
      @group = Group.includes(:users).find(params[:id])
      add_current_user_to_group(@group)
    else
      @recipient = User.find_by(id: params[:recipient_id])
      @group = find_or_create_private_group
    end

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

  def find_or_create_private_group
    Group.find_or_create_private_group(current_user, @recipient)
  end

  def add_current_user_to_group(group)
    Group.add_user_to_public_group(current_user, group)
  end
end
