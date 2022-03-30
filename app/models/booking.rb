class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :slot

  validates :score, presence: true

  enum score: [:cannot, :can, :want]
end
