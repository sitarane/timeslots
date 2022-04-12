class AddWinnerToSlots < ActiveRecord::Migration[7.0]
  def change
    add_column :slots, :winner, :integer
  end
end
