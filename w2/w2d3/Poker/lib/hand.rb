require_relative './poker_hands'

class Hand
  include PokerHands

  attr_reader :cards

  def initialize(cards)
    raise 'must have five cards' unless cards.count == 5
    @cards = cards.sort
  end

  def self.winner(hands)
  end

  def trade_cards(old_cards, new_cards)
    raise "must have five cards" unless old_cards.count == new_cards.count
    raise "cannot discard unowned card" unless has_cards?(old_cards)
    discard_cards(old_cards)
    take_cards(new_cards)
  end

  def to_s
    cards.join(' ')
  end

  private
  
  def sort!
  end

  def take_cards(cards)
    @cards.push(cards)
  end

  def discard_cards(old_cards)
  end

  def has_cards?(old_cards)
  end
end
