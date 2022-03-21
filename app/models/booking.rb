class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :slot

  enum score: {
    cant: 0,
    can: 1,
    will: 2
  }
end
