require_relative './card'
require_relative './hand'

class Deck
  def self.all_cards
    start_deck = []
    Card.suits.each do |suit|
      Card.values.each do |value|
        start_deck << Card.new(suit, value)
      end
    end
    start_deck
  end

  def initialize(cards = Deck.all_cards)
    @cards = cards
  end

  def deal_hand
    Hand.new(take(5))
  end

  def count
    @cards.length
  end

  def take(n)
    raise "not enough cards" if n > count
    @cards.shift(n)
  end

  def return(cards)
    @cards += cards
  end

  def shuffle
    @cards.shuffle!
  end
end
