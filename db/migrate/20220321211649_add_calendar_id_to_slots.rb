class AddCalendarIdToSlots < ActiveRecord::Migration[7.0]
  def change
    add_reference :slots, :calendar, null: false, foreign_key: true
  end
end
