# frozen_string_literal: true

module Groups::GroupFactory
  class << self
    def call(id:, recipient:, user:, type:)
      case type
      when :private_chat
        Group.find_or_create_private_group(user, recipient)
      when :public_chat
        Group.find_public_group_and_add_user(user, id)
      else
        raise "Unknown type: #{type}"
      end
    end
  end
end
