class AddCalendarsUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :calendars_users, id: false do |t|
      t.belongs_to :calendar
      t.belongs_to :user
    end
  end
end
