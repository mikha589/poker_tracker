class CreateJoinTablePokerSessionsTags < ActiveRecord::Migration[8.1]
  def change
    create_join_table :poker_sessions, :tags do |t|
      # t.index [:poker_session_id, :tag_id]
      # t.index [:tag_id, :poker_session_id]
    end
  end
end
