require_relative 'card'

class Deck

  attr_accessor :deck, :@discarded_cards

  def initialize
    @deck = populate_deck
    @discarded_cards = []
  end

  def populate_deck
    result = []
    Card.values.each do |value|
      Card.suits.each do |suit|
        result << Card.new(value, suit)
      end
    end
    result
  end

  def shuffle!
    @deck.shuffle!
  end

  def deal
    card = @deck.shift
    @discarded_cards << card
  end

  def return_cards(card)
    until @discarded_cards.empty?
      @deck << @discarded_cards.shift
    end
  end
end
