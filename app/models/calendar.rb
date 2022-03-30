class Calendar < ApplicationRecord
  has_and_belongs_to_many :users
  has_many :slots, dependent: :destroy

  validates :users, presence: true
  validates :advance_warning, numericality: :only_integer

  def user
    return false if users.count != 1
    return users.first
  end
end
