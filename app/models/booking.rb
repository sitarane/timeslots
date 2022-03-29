class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :slot

  validates :score, presence: true

  enum score: {
    cannot: 0,
    can: 1,
    want: 2
  }
end