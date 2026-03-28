class CreatePokerSessions < ActiveRecord::Migration[8.1]
  def change
    create_table :poker_sessions do |t|
      t.date :date
      t.string :location
      t.string :game_format
      t.integer :limit
      t.integer :duration
      t.integer :buy_in
      t.integer :cashout
      t.text :notes

      t.timestamps
    end
  end
end
