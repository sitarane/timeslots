require "test_helper"

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "route should route" do
    assert_routing '/', { :controller => "pages", :action => "home" }
  end
  test "should get homepage" do
    get "/"
    assert_response :success
    assert_select 'h1'
  end
end
