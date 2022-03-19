class Slot < ApplicationRecord
  belongs_to :user
  validates :name, presence: true
  validates :start_time, presence: true
  validate :future_start

  def future_start
    errors.add(:start_time, I18n.t(:future_start)) if self.start_time && self.start_time < Time.now
  end
end
