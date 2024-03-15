# frozen_string_literal: true

module Groups::GroupPrivateService
  extend ActiveSupport::Concern

  included do
    class << self
      def find_or_create_private_group(user, recipient)
        group = find_private_group_with_users(user.id, recipient.id)
        group || create_private_room(user, recipient, group_name(user, recipient))
      end

      # rubocop:disable Metrics/MethodLength
      def create_private_room(user, recipient, room_name)
        group = nil
        ActiveRecord::Base.transaction do
          group = create!(
            name: room_name,
            is_private: true
          )

          group.memberships.create!(
            user_id: user.id,
            recipient_id: recipient.id,
            group_id: group.id
          )
        end

        group
      end
      # rubocop:enable Metrics/MethodLength

      def find_private_group_with_users(user_id, recipient_id)
        complex_condition = <<-SQL
          (memberships.user_id = :current_user_id AND memberships.recipient_id = :rec_id)
          OR
          (memberships.recipient_id = :current_user_id AND memberships.user_id = :rec_id)
        SQL

        joins(:memberships)
          .where(is_private: true)
          .where(complex_condition, current_user_id: user_id, rec_id: recipient_id)
          .take
      end

      def group_name(current_user, recipient)
        "chat_#{current_user.id}_#{recipient.id}"
      end
    end
  end
end
