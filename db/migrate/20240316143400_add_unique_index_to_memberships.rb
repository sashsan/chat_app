class AddUniqueIndexToMemberships < ActiveRecord::Migration[7.1]
  def change
    add_index :memberships, [:user_id, :recipient_id, :group_id], unique: true
  end
end
