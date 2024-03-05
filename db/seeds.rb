# frozen_string_literal: true

User.destroy_all
Group.destroy_all
Membership.destroy_all
Message.destroy_all

user1 = User.create!(
  email: 'user1@mail.com',
  password: '123456',
  password_confirmation: '123456'
)

user2 = User.create!(
  email: 'user2@mail.com',
  password: '123456',
  password_confirmation: '123456'
)

user3 = User.create!(
  email: 'user3@mail.com',
  password: '123456',
  password_confirmation: '123456'
)

group = Group.create!(name: 'Все пользователи')

group.users << user1
group.users << user2
group.users << user3

puts '... sedded ...'
