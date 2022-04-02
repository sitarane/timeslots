module CalendarsHelper
  def want_assignation(score_board)
    assigned = Hash.new
    score_board.each do |slot, score_list|
      want_count = 0
      winner = 0
      score_list.each do |guest, score|
        if score > 0
          want_count +=1
          winner = guest
        end
      end
      if want_count == 1 # We have a winner
        assigned[slot] = winner
        score_board.delete(slot)
        score_board.each_value do |score_list|
          score_list.delete(winner)
        end
      end
    end
    assigned # { slot => winner }
  end

  def cannot_assignation(score_board)
    assigned = Hash.new
    score_board.each do |slot, score_list|
      cannot_count = 0
      winner = 0
      score_list.each do |guest, score|
        if score < 0
          cannot_count +=1
        else
          winner = guest
        end
      end
      if score_list.length == cannot_count + 1
        assigned[slot] = winner
        score_board.delete(slot)
        score_board.each_value do |score_list|
          score_list.delete(winner)
        end
      end
    end
    assigned
  end
end
