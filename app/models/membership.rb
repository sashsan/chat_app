# frozen_string_literal: true

class Membership < ApplicationRecord
  belongs_to :user
  belongs_to :group

  validates :user_id, uniqueness: { scope: %i[recipient_id group_id] }
end
