# frozen_string_literal: true

class Group < ApplicationRecord
  include Groups::GroupPrivateService
  include Groups::GroupPublicService

  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships
  has_many :messages, dependent: :destroy

  scope :except_private, -> { where(is_private: false) }
  scope :with_user, ->(user_id) { joins(:memberships).where(memberships: { user_id: user_id}) }
end
