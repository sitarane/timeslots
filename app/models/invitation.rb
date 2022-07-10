class Invitation < ApplicationRecord
  belongs_to :user
  belongs_to :calendar

  # after_create :send_email you now have access to private calendar

  validates :user, presence: true
  validates :calendar, presence: true

  def generate_token
    self.token = Digest::SHA1.hexdigest([Time.now, rand].join)
  end
end
