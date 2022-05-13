class User < ApplicationRecord
  has_many :bookings, dependent: :destroy
  has_many :slots, through: :bookings

  # adds virtual attributes for authentication
  has_secure_password

  validates :name, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true, format: { with: /\A[^@\s]+@[^@\s]+\z/, message: 'Invalid email' }
end
