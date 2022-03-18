require "test_helper"

class ApplicationControllerTest < ActionDispatch::IntegrationTest
  test 'switch language' do
    get root_url(locale: :de)
    assert_response :success
  end
end
