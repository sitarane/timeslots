class User < ApplicationRecord
  has_and_belongs_to_many :calendars
  has_many :bookings, dependent: :destroy
  has_many :slots, through: :bookings

  # adds virtual attributes for authentication
  has_secure_password
  # validates email
  validates :name, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true, format: { with: /\A[^@\s]+@[^@\s]+\z/, message: 'Invalid email' }
end
