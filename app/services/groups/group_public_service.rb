# frozen_string_literal: true

module Groups::GroupPublicService
  extend ActiveSupport::Concern

  included do
    class << self
      def find_public_group_and_add_user(current_user, group_id)
        group = Group.find_by(id: group_id)
        raise 'Group is nil' if group.nil?

        group.users << current_user unless group.users.include?(current_user)
        group
      end
    end
  end
end
