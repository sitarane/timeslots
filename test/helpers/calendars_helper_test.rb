require "test_helper"
class CalendarsHelperTest < ActionView::TestCase
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
  end
  test '#assign_wanted_only_by_one' do
    assert assign_wanted_only_by_one(@score_board) == { 3 => 4 }
    assert @score_board.length == 3
  end
  test '#assign_hated_by_all_minus_one' do
    assert assign_hated_by_all_minus_one(@score_board) == { 2 => 1 }
    assert @score_board.length == 3
  end
  test '#assign_most_wanted' do
    assert assign_most_wanted(@most_wanted) == { 1 => 2 }
    assert @most_wanted.length == 1
  end
  test '#assign_most_hated_to_someone_who_wants_it' do
    assert assign_most_hated_to_someone_who_wants_it(@score_board) == { 2 => 1 }
    assert @score_board.length == 3
    assert assign_most_hated_to_someone_who_wants_it(@most_hated) == { 3 => 1 }
    assert @most_hated.length == 2
  end
end
