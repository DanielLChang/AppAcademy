require_relative './card'
require_relative './hand'

class Deck
  def self.all_cards
  end

  def initialize(cards = Deck.all_cards)
    @cards = cards
  end

  def deal_hand
  end

  def count
  end

  def take(n)
  end

  def return(cards)
  end

  def shuffle
  end
end
