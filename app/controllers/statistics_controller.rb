class StatisticsController < ApplicationController
  def index
    @sessions = current_user.poker_sessions.by_format(params[:game_format]).by_location(params[:location]).by_duration(params[:duration]).by_buy_in(params[:buy_in]).by_cashout(params[:cashout])

    @stats = PokerStatsCalculator.new(@sessions)
  end
end
