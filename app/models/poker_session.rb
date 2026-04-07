class PokerSession < ApplicationRecord
  belongs_to :user
  has_many :poker_sessions_tags
  has_many :tags, through: :poker_sessions_tags

  validates :date, presence: true
  validates :location, presence: true
  validates :game_format, presence: true
  validates :limit, presence: true
  validates :duration, presence: true
  validates :buy_in, presence: true
  validates :cashout, presence: true

  def tag_list
    tags.map(&:name).join(", ")
  end

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
  scope :by_date_range, ->(start_date, end_date) { where(created_at: start_date.to_date.beginning_of_day..end_date.to_date.end_of_day) if start_date.present? && end_date.present? }
  scope :by_tag, ->(tag_id) { joins(:tags).where(tags: { id: tag_id }).distinct if tag_id.present? }

  def profit
    cashout - buy_in
  end
end
