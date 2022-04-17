require "test_helper"

class AssignWinnerJobTest < ActiveJob::TestCase
  setup { @slot = slots(:one) }
  test 'assigns winner' do
    AssignWinnerJob.perform_now(@slot)
    debugger
    assert @slot.winner
  end
end
