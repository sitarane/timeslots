class UpdateAdvanceWarningDefaultTo0Calendars < ActiveRecord::Migration[7.0]
  def change
    change_column_default :calendars, :advance_warning, from: nil, to: 0
  end
end
