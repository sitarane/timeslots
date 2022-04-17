class Slot < ApplicationRecord
  belongs_to :calendar
  has_many :bookings, dependent: :destroy

  validates :start_time, presence: true
  validate :future_start

  after_create :enqueue_assign_winner_job

  private

  def enqueue_assign_winner_job
    AssignWinnerJob.set(
      wait_until: self.start_time - self.calendar.advance_warning.days
    ).perform_later self
  end

  def future_start
    errors.add(:start_time, I18n.t(:future_start)) if self.start_time && self.start_time < Time.now
  end
end
