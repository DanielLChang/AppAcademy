require_relative './player'
require_relative './deck'

class Game
  attr_reader :players, :pot, :deck

  def initialize
    @players = []
    @pot = 0
    @deck = Deck.new
  end

  def play
  end

  def play_round
  end

  def unfold_players
  end

  def deal_cards
  end

  def take_bets
  end

  def trade_cards
  end

  def end_round
  end

  def winner
  end

  def show_hands
  end

  def add_to_pot(amount)
  end

  def game_over?
  end

  def add_players(n, buy_in)
  end
end

def test
  g = Game.new
  g.add_players(2, 100)
  g.play_round
end
