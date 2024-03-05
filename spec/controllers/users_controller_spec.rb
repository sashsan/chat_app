# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET #index' do
    context 'when user is not authenticated' do
      it 'redirects to the sign-in page' do
        get :index
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'when user is authenticated' do
      login_current_user

      it 'assigns @users' do
        create_list(:user, 2)
        get :index

        expect(assigns(:users).count).to eq(3)
      end
    end
  end
end
