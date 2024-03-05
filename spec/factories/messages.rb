# frozen_string_literal: true

FactoryBot.define do
  factory :message do
    association :user
    association :group
    content { 'Привет' }
  end
end
