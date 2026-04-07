class Tag < ApplicationRecord
  has_many :poker_sessions_tags
  has_many :poker_sessions, through: :poker_sessions_tags
end
