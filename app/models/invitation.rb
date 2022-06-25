class Invitation < ApplicationRecord
  belongs_to :user
  belongs_to :calendar

  before_validation :generate_token
  # after_create :send_email you now have access to private calendar

  validates :token, presence: true, uniqueness: true
  validates :user, presence: true
  validates :calendar, presence: true

  private

  def generate_token
    self.token = Digest::SHA1.hexdigest([Time.now, rand].join)
  end
end
