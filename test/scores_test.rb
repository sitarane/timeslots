require "test_helper"

class ScoresTest < ActiveSupport::TestCase
  include Scores
  def setup
    # { slot => user => score }
    @score_board = {
      1=>{
        1=>0.5,
        2=>0.5,
        3=>-1/3,
        4=>0
      },
      2=>{
        1=>0,
        2=>-0.5,
        3=>-1/3,
        4=>-0.5
      },
      3=>{
        1=>0,
        2=>0,
        3=>1/3,
        4=>0.5 # this one
      },
      4=>{
        1=>-0.5,
        2=>0,
        3=>0,
        4=>0
      }
    }
    @most_wanted = {
      1=>{
        1=>0.2,
        2=>0.5 # most wanted
      },
      2=>{
        1=>-0.2,
        2=>-0.5
      }
    }
    @most_hated = {
      1=>{
        1=>0,
        2=>0
      },
      2=>{
        1=>0,
        2=>-0.5
      },
      3=>{ # most hated
        1=>0,
        2=>-0.7
      }
    }
    @bad_board = {
      1=>{
        1=>-1,
        2=>-1
      },
      2=>{
        1=>-1,
        2=>-1
      }
    }
  end
  test '#assign_wanted_only_by_one' do
    assert Scores::AssignationBoard.new(@score_board).assign_wanted_only_by_one == { 3 => 4 }
    assert @score_board.length == 3
  end
  test '#assign_hated_by_all_minus_one' do
    assert Scores::AssignationBoard.new(@score_board).assign_hated_by_all_minus_one == { 2 => 1 }
    assert @score_board.length == 3
  end
  test '#assign_most_wanted' do
    assert Scores::AssignationBoard.new(@most_wanted).assign_most_wanted == { 1 => 2 }
    assert @most_wanted.length == 1
  end
  test '#assign_most_hated_to_someone_who_wants_it' do
    assert Scores::AssignationBoard.new(@score_board).assign_most_hated_to_someone_who_wants_it == { 2 => 1 }
    assert @score_board.length == 3
    assert Scores::AssignationBoard.new(@most_hated).assign_most_hated_to_someone_who_wants_it == { 3 => 1 }
    assert @most_hated.length == 2
  end
  test '#assign_at_random' do
    assert Scores::AssignationBoard.new(@most_wanted).assign_at_random == { 1 => 1 }
    assert @most_wanted.length == 1
    assert Scores::AssignationBoard.new(@most_hated).assign_at_random == { 1 => 1 }
    assert @most_hated.length == 2
    assert Scores::AssignationBoard.new(@bad_board).assign_at_random == { 1 => 1 }
    assert @bad_board.length == 1
  end
end
