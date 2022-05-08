class Calendar < ApplicationRecord
  include Hashid::Rails
  
  has_and_belongs_to_many :users
  has_many :slots, dependent: :destroy

  validates :name, presence: true
  validates :users, presence: true
  validates :advance_warning, numericality: :only_integer, presence: true

  def user
    return false if users.count != 1
    return users.first
  end

  def bookings
    bookings_list = Array.new
    slots.each do |slot|
      slot.bookings.each do |booking|
        bookings_list << booking
      end
    end
    bookings_list
  end

  def guests
    guest_list = Array.new
    bookings.each do |booking|
      guest_list |= [booking.user]
    end
    guest_list
  end

  def score_board
    guest_list = guests # run once because expensive
    guest_scored_count = guest_scored_count(guest_list)
    board = Hash.new
    slots.each do |slot|
      next if slot.winner
      board[slot.id] = slot_score_list(slot, guest_list, guest_scored_count)
    end
    board
  end

  private

  def guest_scored_count(guest_list) # count how many scores each user gave
    count = Hash.new
    guest_list.each do |guest|
      score_count = 0
      guest.bookings.each do |booking|
        next unless slots.include?(booking.slot)
        next if booking.score == "can"
        score_count += 1
      end
      count[guest.id] = score_count
    end
    count
  end

  def slot_score_list(slot, guest_list, guest_scored_count)
    guest_score_list = Hash.new

    # make a list of the scores given by each guest
    guest_list.each do |guest|
      booking = guest.bookings.where(slot: slot).first
      if booking
        guest_score_list[guest.id] = booking.score
      else # if no score given
        guest_score_list[guest.id] = 'can'
      end
    end

    # calculate a numeric score for each choice
    guest_score_list.each do |guest_id, score|
      if score == "cannot"
        guest_score_list[guest_id] = -1.0 / guest_scored_count[guest_id]
      elsif score == "want"
        guest_score_list[guest_id] = 1.0 / guest_scored_count[guest_id]
      else # can is equivalent to no choice
        guest_score_list[guest_id] = 0
      end
    end

    # at this point list should only have numeric values
    guest_score_list
  end
end
