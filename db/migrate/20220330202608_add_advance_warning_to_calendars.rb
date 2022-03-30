class AddAdvanceWarningToCalendars < ActiveRecord::Migration[7.0]
  def change
    add_column :calendars, :advance_warning, :integer
  end
end
