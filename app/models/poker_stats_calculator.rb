class PokerStatsCalculator
  def initialize(sessions)
    @sessions = sessions.to_a
  end

  def total_profit
    @sessions.sum(&:profit)
  end

  def total_loss
    @sessions.min_by(&:profit)
  end

  def hourly_rate
    total_hours = @sessions.sum { |s| s.duration || 0 }.to_f
    return 0 if total_hours == 0
    (total_profit / total_hours).round(2)
  end

  def stats_by_format_and_location
    grouped = @sessions.group_by { |s| [ s.game_format, s.location ] }

    grouped.map do |(format, location), sessions|
      p = sessions.sum(&:profit)
      b = sessions.sum { |s| s.buy_in || 0 }
      h = sessions.sum { |s| s.duration || 0 }.to_f

      {
        format: format,
        location: location,
        profit: p,
        roi: (b > 0) ? ((p.to_f / b) * 100).round(2) : 0,
        hourly: (h > 0) ? (p / h).round(2) : 0
      }
    end
  end

  def cumulative_bankroll
    sum = 0
    @sessions.sort_by(&:created_at).map do |session|
      sum += session.profit
      { date: session.created_at, amount: sum }
    end
  end

  def stats_by_format
    grouped = @sessions.group_by(&:game_format)
    grouped.map do |format_name, sessions|
      p = sessions.sum(&:profit)
      b = sessions.sum { |s| s.buy_in || 0 }
      h = sessions.sum { |s| s.duration || 0 }.to_f

      {
        name: format_name,
        profit: p,
        roi: (b > 0) ? ((p.to_f / b) * 100).round(2) : 0,
        hourly: (h > 0) ? (p / h).round(2) : 0
      }
    end
  end

  def streak_win
    streak = 0
    @sessions.reverse_each do |session|
      if session.profit > 0
        streak += 1
      else
        break
      end
    end
    streak
  end
end
