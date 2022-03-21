class RemoveUserIdFromSlots < ActiveRecord::Migration[7.0]
  def change
    remove_index :slots, :user_id
    remove_column :slots, :user_id, :string
  end
end
