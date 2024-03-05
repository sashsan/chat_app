# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  login_current_user

  describe 'GET #index' do
    it 'assigns all users except the current_user to @users' do
      other_user = create(:user)
      get :index
      expect(assigns(:users)).to eq([other_user])
    end

    it 'assigns all non-private groups to @groups' do
      public_group = create(:group, is_private: false)
      create(:group, is_private: true)
      get :index
      expect(assigns(:groups)).to eq([public_group])
    end
  end
end
