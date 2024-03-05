# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MessagesController, type: :controller do
  login_current_user

  let(:group) { create(:group) }
  let(:valid_attributes) { attributes_for(:message) }
  let(:invalid_attributes) { { content: '' } }

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Message' do
        expect do
          post :create, params: { group_id: group.id, message: valid_attributes }
        end.to change(Message, :count).by(1)
      end

      it "redirects to the created message's group" do
        post :create, params: { group_id: group.id, message: valid_attributes }

        expect(response).to have_http_status(:no_content)
      end

      it 'broadcasts the message' do
        allow(ChatChannel).to receive(:broadcast_to)

        post :create, params: { group_id: group.id, message: valid_attributes }

        expect(ChatChannel).to have_received(:broadcast_to).with(group, anything)
      end
    end
  end
end
