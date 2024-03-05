# frozen_string_literal: true

class User < ApplicationRecord
  include Users::UserService

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates_uniqueness_of :email

  has_many :memberships
  has_many :groups, through: :memberships
  has_many :messages, dependent: :destroy

  scope :except_me, ->(user) { where.not(id: user&.id) }
end
