module Scores
  class Build
  end
  class Assign
    def initialize(calendar)
      @score_board = calendar.score_board
      @guest_count = @score_board.any? ? @score_board.values.first.length : 0
    end
    def call
      assignations = Hash.new # slot => user
      old_length = 0
      until @score_board.length == old_length
        old_length = @score_board.length

        assignations.merge!(calculated_assignations)
        return assignations if @score_board.empty? || assignations.length == @guest_count

        assignations.merge!(assign_at_random)
        return assignations if @score_board.empty? || assignations.length == @guest_count
      end
      return assignations
    end

    def calculated_assignations
      assignations = Hash.new # slot => user
      old_length = 0
      until @score_board.length == old_length
        old_length = @score_board.length

        assignations.merge!(assign_first_pass)
        return assignations if @score_board.empty? || assignations.length == @guest_count

        assignations.merge!(assign_most_hated_to_someone_who_wants_it)
        return assignations if @score_board.empty? || assignations.length == @guest_count
      end
      return assignations
    end

    def assign_first_pass
      assignations = Hash.new
      old_length = 0
      until @score_board.length == old_length
        old_length = @score_board.length

        assignations.merge!(assign_wanted_only_by_one)
        return assignations if @score_board.empty? || assignations.length == @guest_count

        assignations.merge!(assign_hated_by_all_minus_one)
        return assignations if @score_board.empty? || assignations.length == @guest_count
      end

      assignations.merge!(assign_most_wanted)
      return assignations
    end

    def assign_wanted_only_by_one

      assigned = Hash.new
      old_length = 0
      until @score_board.length == old_length
        old_length = @score_board.length
        @score_board.each do |slot, score_list|
          want_count = 0
          winner = 0
          score_list.each do |guest, score|
            if score > 0
              want_count +=1
              winner = guest
            end
          end
          if want_count == 1

            assigned[slot] = winner
            @score_board.delete(slot)
            @score_board.each_value do |score_list|
              score_list.delete(winner)
            end
          end
        end
      end
      assigned # { slot => winner }
    end

    def assign_hated_by_all_minus_one
      assigned = Hash.new
      @score_board.each do |slot, score_list|
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
          @score_board.delete(slot)
          @score_board.each_value do |score_list|
            score_list.delete(winner)
          end
        end
      end
      assigned
    end

    def assign_most_wanted
      assigned = Hash.new
      @score_board.each do |slot, score_list| # check if there's a highest positive score, assign
        winner = 0
        sorted_list = score_list.sort_by { |_guest, score| score }.reverse # highest first
        next assigned if score_list.empty?
        winner = sorted_list[0]
        next if winner[1] <= 0
        second_winner = sorted_list[1]
        unless winner[1] == second_winner[1]
          assigned[slot] = winner[0]
          @score_board.delete(slot)
          @score_board.each_value do |score_list|
            score_list.delete(winner[0])
          end
        end
      end
      assigned
    end

    def assign_most_hated_to_someone_who_wants_it
      # Check which is the most hated slot, assign to someone who wants it
      hate_list = Hash.new
      @score_board.each do |slot, score_list|
        hate_score = 0
        score_list.each do |_guest, score|
          hate_score += 1 if score < 0
        end
        hate_list[slot] = hate_score
      end
      assigned = Hash.new
      return assigned if hate_list.empty?
      sorted_list = hate_list.sort_by { |slot, hate_score| hate_score }.reverse
      most_hated_slot = sorted_list[0][0]

      # make a list of people who want it
      wanters = @score_board[most_hated_slot].select { |_guest, score| score >= 0 }
      if wanters.any?
        winner = wanters.keys.sample
        assigned[most_hated_slot] = winner

        @score_board.delete(most_hated_slot)
        @score_board.each_value do |score_list|
          score_list.delete(winner)
        end
      end
      assigned
    end


    def assign_at_random
      # Change to first arrived first served
      # Try to assign the first wanted slot
      assigned = Hash.new
      @score_board.each do |slot, score_list|
        score_list.each do |guest, score|
          if score > 0
            assigned[slot] = guest
            @score_board.delete(slot)
            @score_board.each_value do |score_list|
              score_list.delete(guest)
            end
            return assigned
          end
        end
      end

      # Try to assign the first can-ed slot
      @score_board.each do |slot, score_list|
        score_list.each do |guest, score|
          if score == 0
            assigned[slot] = guest
            @score_board.delete(slot)
            @score_board.each_value do |score_list|
              score_list.delete(guest)
            end
            return assigned
          end
        end
      end

      # assign whatever
      slot = @score_board.keys.first
      winner = @score_board.values.first.keys.first
      assigned = {slot => winner}
      @score_board.delete(slot)
      @score_board.each_value do |score_list|
        score_list.delete(winner)
      end
      return assigned
    end
  end
end
