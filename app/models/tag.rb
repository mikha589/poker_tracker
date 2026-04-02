class Tag < ApplicationRecord
    has_and_belongs_to_many :poker_sessions
end
