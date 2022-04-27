require "test_helper"

class GameStatusesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get game_statuses_index_url
    assert_response :success
  end
end
