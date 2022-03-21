class CreateBookings < ActiveRecord::Migration[7.0]
  def change
    create_table :bookings do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :slot, null: false, foreign_key: true
      t.integer :score

      t.timestamps
    end
  end
end
