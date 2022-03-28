class Calendar < ApplicationRecord
  has_and_belongs_to_many :users
  has_many :slots, dependent: :destroy

  validates :users, presence: true

  def user
    return false if users.count != 1
    return users.first
  end
end
