require "test_helper"

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get team" do
    get team_path
    assert_response :success
  end

  test "should get contact" do
    get contact_path
    assert_response :success
  end
end
