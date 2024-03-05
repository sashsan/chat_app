# frozen_string_literal: true

module Groups::GroupPublicService
  extend ActiveSupport::Concern

  included do
    class << self
      def add_user_to_public_group(current_user, group)
        group.users << current_user unless group.users.include?(current_user)
      end
    end
  end
end
