class AddRecipientIdToMemberships < ActiveRecord::Migration[7.1]
  def change
    add_column :memberships, :recipient_id, :integer
  end
end
