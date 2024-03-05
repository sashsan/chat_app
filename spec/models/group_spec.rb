# frozen_string_literal: true

describe 'scopes' do
  let!(:private_group) { create(:group, is_private: true) }
  let!(:public_group) { create(:group, is_private: false) }
  let!(:user) { create(:user) }

  describe '.except_private' do
    it 'includes only public groups' do
      expect(Group.except_private).to include(public_group)
      expect(Group.except_private).not_to include(private_group)
    end
  end

  describe '.with_user' do
    before do
      public_group.users << user
    end

    it 'includes groups with specified user' do
      expect(Group.with_user(user.id)).to include(public_group)
      expect(Group.with_user(user.id)).not_to include(private_group)
    end
  end
end
