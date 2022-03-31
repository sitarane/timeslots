class Calendar < ApplicationRecord
  has_and_belongs_to_many :users
  has_many :slots, dependent: :destroy

  validates :users, presence: true
  validates :advance_warning, numericality: :only_integer

  def user
    return false if users.count != 1
    return users.first
  end

  def bookings
    slots.each do |slot|
      slot.bookings
    end
  end

  def guests
    list = Array.new
    slots.each do |slot|
      slot.bookings.each do |booking|
        list |= [booking.user]
      end
    end
  end

  def score_board
    board = Hash.new
    slots.each do |slot|
      board[slot.id] = slot_score_list(slot)
    end
    board
  end

  private

  def slot_score_list(slot)
    list = Hash.new

    # make a list of the scores given by each guest
    guests.each do |guest|
      booking = guest.bookings.where(slot: slot).first
      if booking
        list[guest.id] = booking.score
      else # if no score given
        list[guest.id] = 0
      end
    end

    # count how many users gave a score to this slot
    scored_count = 0
    list.each do |_guest_id, score|
      scored_count += 1 unless score == 0
    end

    # calculate a numeric score for each choice
    list.each do |guest_id, score|
      if score == "cannot"
        list[guest_id] = -1 / scored_count
      elsif score == "want"
        list[guest_id] = 1 / scored_count
      else # can is equivalent to no choice
        list[guest_id] = 0
      end
    end

    # at this point list should only have numeric values
    list
  end
end
