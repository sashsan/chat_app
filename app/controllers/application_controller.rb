# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private

  def after_sign_out_path_for(_res)
    cookies.delete(:user_id)
    super
  end

  def after_sign_in_path_for(_res)
    root_path
  end
end
