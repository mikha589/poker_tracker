class User < ApplicationRecord
  has_many :poker_sessions
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
