require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase
  test 'create new user' do
    visit new_users_url
    fill_in 'Name', with: 'Alberto'
    fill_in 'Email', with: 'alberto@mail.com'
    fill_in 'Password', with: 'superman69'
    fill_in 'Password confirmation', with: 'superman69'
    click_on "signup"

    assert_text 'Successfully created account'
  end
end
