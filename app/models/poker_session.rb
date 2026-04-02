class PokerSession < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :tags
  def tag_list
    tags.map(&:name).join(", ")
  end

  # Этот метод вызывается, когда мы сохраняем форму
  def tag_list=(names)
    self.tags = names.split(",").map do |n|
      Tag.where(name: n.strip).first_or_create!
    end
  end

  scope :by_format, ->(f) { where(game_format: f) if f.present? }
  scope :by_location, ->(l) { where(location: l) if l.present? }
  scope :by_duration, ->(d) { where(duration: d) if d.present? }
  scope :by_buy_in, ->(b) { where(buy_in: b) if b.present? }
  scope :by_cashout, ->(c) { where(cashout: c) if c.present? }
  scope :by_date_range, ->(start_date, end_date) { where(created_at: start_date.to_date.beginning_of_day..end_date.to_date.end_of_day) if start_date.present? && end_date.present?}
  scope :by_tags, ->(t) { joins(:tags).where(tags: { name: t }).distinct if t.present? }

  def profit
    (cashout || 0) - (buy_in || 0)
  end
end
