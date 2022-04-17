class AssignWinnerJob < ApplicationJob
  include Scores
  queue_as :default

  def perform(slot)
    assignations = ScoreBoard.new(slot.calendar.score_board).assign_slots
    return slot.winner = assignations[slot.id]
  end
end
