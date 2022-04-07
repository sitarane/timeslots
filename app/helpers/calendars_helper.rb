module CalendarsHelper

  def assign_wanted_only_by_one(score_board)
    puts 'Trying to assign slots wanted by one person'
    assigned = Hash.new
    old_board = Hash.new
    until score_board == old_board
      old_board = score_board
      score_board.each do |slot, score_list|
        want_count = 0
        winner = 0
        score_list.each do |guest, score|
          if score > 0
            want_count +=1
            winner = guest
          end
        end
        if want_count == 1
          puts "The winner for slot #{slot} is guest #{winner}"
          assigned[slot] = winner
          score_board.delete(slot)
          score_board.each_value do |score_list|
            score_list.delete(winner)
          end
        else
          puts 'No winner :('
        end
      end
    end
    assigned # { slot => winner }
  end

  def assign_hated_by_all_minus_one(score_board)
    puts 'Will try to assign slots that no one wants, except one'
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
        puts "We thank guest #{winner} to be the only one to want slot #{slot}"
        assigned[slot] = winner
        score_board.delete(slot)
        score_board.each_value do |score_list|
          score_list.delete(winner)
        end
      else
        puts 'No luck finding a good home for less wanted slots'
      end
    end
    assigned
  end

  def assign_most_wanted(score_board)
    puts 'Will now just give the most wanted slot to whomever wants it most'
    assigned = Hash.new
    score_board.each do |slot, score_list| # check if there's a highest positive score, assign
      winner = 0
      sorted_list = score_list.sort_by { |_guest, score| score }.reverse # highest first
      winner = sorted_list[0]
      next if winner[1] <= 0
      second_winner = sorted_list[1]
      unless winner[1] == second_winner[1]
        puts "Guest #{winner[0]} is so hungry we gave them slot #{slot}"
        assigned[slot] = winner[0]
        score_board.delete(slot)
        score_board.each_value do |score_list|
          score_list.delete(winner[0])
        end
      else
        puts 'Our advanced matching algorythm didnt find matches'
      end
    end
    assigned
  end

  def assign_most_hated_to_someone_who_wants_it(score_board)
    puts 'Will now give a hated slot to anyone who wants it'
    # Check which is the most hated slot, assign to someone who wants it
    hate_list = Hash.new
    score_board.each do |slot, score_list|
      hate_list[slot] = 0
      score_list.each do |guest, score|
        hate_list[slot] += score if score < 0
      end
    end
    sorted_list = hate_list.sort_by { |slot, hate_score| hate_score }
    most_hated_slot = sorted_list[0][0]

    # make a list of people who want it
    wanters = score_board[most_hated_slot].select { |_guest, score| score >= 0 }
    assigned = Hash.new
    if wanters
      winner = wanters.keys.sample
      assigned[most_hated_slot] = winner
      puts "We're glad that guest #{winner} didn't hate slot #{most_hated_slot}, because many did."
      score_board.delete(most_hated_slot)
      score_board.each_value do |score_list|
        score_list.delete(winner)
      end
    else
      puts 'Couldnt find someone who wanted our most hated slots'
    end
    assigned
  end


  def assign_at_random
    # hopefully I never need to write this
  end
end
