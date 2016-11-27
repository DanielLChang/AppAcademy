class Player
  attr_reader :bankroll, :hand

  def self.buy_in(bankroll)
    Player.new(bankroll)
  end

  def initialize(bankroll)
    @bankroll = bankroll
  end

  def deal_in(hand)
  end

  def respond_bet
  end

  def get_bet
  end

  def get_cards_to_trade
  end

  def take_bet(amount)
  end

  def receive_winnings(amount)
  end

  def return_cards
  end

  def fold
  end

  def unfold
  end

  def folded?
  end

  def trade_cards(old_cards, new_cards)
  end

  def <=>(other_player)
  end
end
