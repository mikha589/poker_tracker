require "test_helper"

class PokerSessionFlowTest < ActionDispatch::IntegrationTest
  test "should not access other user's session" do
    sign_in users(:one)
    other_session = poker_sessions(:two)

    get poker_session_url(other_session)
    assert_response :not_found
  end

  test "should get statistics page" do
    sign_in users(:one)
    get statistics_url
    assert_response :success
  end
end
