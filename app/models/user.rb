class User < ApplicationRecord
  has_many :poker_sessions
  has_many :exports
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable
end
