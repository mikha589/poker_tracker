require "test_helper"

class PokerSessionTest < ActiveSupport::TestCase
  test "invalid without required fields" do
    session = poker_sessions(:one)
    assert session.valid?
  end

  test "invalid without date" do
    session = poker_sessions(:one)
    session.date = nil
    assert_not session.valid?
  end

  test "invalid without location" do
    session = poker_sessions(:one)
    session.location = nil
    assert_not session.valid?
  end

  test "invalid without duration" do
    session = poker_sessions(:one)
    session.duration = nil
    assert_not session.valid?
  end

  test "invalid without buy-in" do
    session = poker_sessions(:one)
    session.buy_in = nil
    assert_not session.valid?
  end

  test "invalid without cashout" do
    session = poker_sessions(:one)
    session.cashout = nil
    assert_not session.valid?
  end

  test "should calculate correct profit and stats" do
    session = poker_sessions(:one)
    assert_equal 400, session.profit
  end
end
