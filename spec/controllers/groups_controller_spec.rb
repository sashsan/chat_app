# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GroupsController, type: :controller do
  describe 'GET #index' do
    login_current_user

    it 'assigns @groups excluding private groups' do
      public_group = create(:group, is_private: false)
      create(:group, is_private: true)
      get :index

      expect(assigns(:groups)).to match_array([public_group])
    end

    it 'renders the index template' do
      get :index

      expect(response).to render_template('index')
    end
  end

  describe 'GET #show for group chat' do
    login_current_user

    it 'adds current_user to the group if not a member' do
      group = create(:group, is_private: false)
      get :show, params: { id: group.id, group_chat: true }

      expect(group.users).to include(subject.current_user)
    end
  end

  describe 'GET #show for private chat' do
    login_current_user

    it 'finds or creates a private group between users' do
      group = create(:group, is_private: false)
      recipient = create(:user)

      expect do
        get :show, params: { id: group.id, recipient_id: recipient.id }
      end.to change(Group, :count).by(1)
    end
  end
end
