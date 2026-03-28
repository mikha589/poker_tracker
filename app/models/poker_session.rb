class PokerSession < ApplicationRecord
    def profit 
        (cashout || 0) - (buy_in || 0)
    end

end
