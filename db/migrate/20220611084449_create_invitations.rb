class CreateInvitations < ActiveRecord::Migration[7.0]
  def change
    create_table :invitations do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :calendar, null: false, foreign_key: true
      t.string :token

      t.timestamps
    end
  end
end
