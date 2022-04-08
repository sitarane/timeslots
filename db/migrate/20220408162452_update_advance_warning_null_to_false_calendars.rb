class UpdateAdvanceWarningNullToFalseCalendars < ActiveRecord::Migration[7.0]
  def change
    change_column_null :calendars, :advance_warning, false
  end
end
