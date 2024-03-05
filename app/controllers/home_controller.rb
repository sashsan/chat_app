# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @users = User.except_me(current_user)
    @groups = Group.except_private
  end
end
