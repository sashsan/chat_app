# frozen_string_literal: true

module Groups::GroupPrivateService
  extend ActiveSupport::Concern

  included do
    class << self
      def find_or_create_private_group(user, recipient)
        group = find_private_group_with_users(user.id, recipient.id)
        group || create_private_room([user, recipient], group_name(user, recipient))
      end

      # rubocop:disable Metrics/MethodLength
      def create_private_room(users, room_name)
        group = nil
        ActiveRecord::Base.transaction do
          group = create!(name: room_name, is_private: true)

          memberships_attributes = users.map do |user|
            { user_id: user.id, group_id: group.id }
          end

          Membership.insert_all(memberships_attributes)
        end
        group
      rescue ActiveRecord::RecordInvalid => e
        flash[:error] = "Произошла ошибка при создании приватной комнаты: #{e.message}"
        nil
      end
      # rubocop:enable Metrics/MethodLength

      def find_private_group_with_users(current_user_id, recipient_id)
        joins(:memberships)
          .where(is_private: true)
          .where(memberships: { user_id: [current_user_id, recipient_id] })
          .group('groups.id')
          .having('COUNT(memberships.user_id) = 2')
          .first
      end

      def group_name(current_user, recipient)
        "chat_#{current_user.id}_#{recipient.id}"
      end
    end
  end
end
