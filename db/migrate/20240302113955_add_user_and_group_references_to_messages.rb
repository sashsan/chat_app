# frozen_string_literal: true

class AddUserAndGroupReferencesToMessages < ActiveRecord::Migration[7.1]
  def change
    add_reference :messages, :user, null: false, foreign_key: true
    add_reference :messages, :group, null: true, foreign_key: true
  end
end
