# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'scopes' do
    describe '.except_me' do
      let!(:user1) { create(:user) }
      let!(:user2) { create(:user) }

      it 'excludes the specified user from the results' do
        expect(User.except_me(user1)).not_to include(user1)
        expect(User.except_me(user1)).to include(user2)
      end
    end
  end
end
