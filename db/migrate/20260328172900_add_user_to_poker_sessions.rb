class AddUserToPokerSessions < ActiveRecord::Migration[8.1]
  def change
    add_reference :poker_sessions, :user, null: false, foreign_key: true
  end
end
