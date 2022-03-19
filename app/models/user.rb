class User < ApplicationRecord
  has_many :slots, dependent: :destroy
  # adds virtual attributes for authentication
  has_secure_password
  # validates email
  validates :name, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true, format: { with: /\A[^@\s]+@[^@\s]+\z/, message: 'Invalid email' }
end
