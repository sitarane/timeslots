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
        4=>0.5
      },
      4=>{
        1=>-0.5,
        2=>0,
        3=>0,
        4=>0
      }
    }
  end
  test '#want_assignation' do
    assert want_assignation(@score_board) == { 3 => 4 }
    assert @score_board.length == 3
  end
  test '#cannot_assignation' do
    assert cannot_assignation(@score_board) == { 2 => 1 }
    assert @score_board.length == 3
  end
end
