# frozen_string_literal: true

module Groups::GroupFactory
  class << self
    def call(id:, recipient:, user:, type:)
      case type
      when :private_chat
        find_or_create_private_group(user, recipient)
      when :public_chat
        group = Group.includes(:users).find(id)
        add_current_user_to_group(user, group)
        group
      else
        raise "Unknown type: #{type}"
      end
    end

    def find_or_create_private_group(user, recipient)
      Group.find_or_create_private_group(user, recipient)
    end

    def add_current_user_to_group(user, group)
      Group.add_user_to_public_group(user, group)
    end
  end
end
