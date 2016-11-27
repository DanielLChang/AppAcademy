class Card
  include Comparable

  SUIT_STRINGS = {
    clubs:    "♣",
    diamonds: "♦",
    hearts:   "♥",
    spades:   "♠"
  }.freeze

  VALUE_STRINGS = {
    two:    "2",
    three:  "3",
    four:   "4",
    five:   "5",
    six:    "6",
    seven:  "7",
    eight:  "8",
    nine:   "9",
    ten:    "10",
    jack:   "J",
    queen:  "Q",
    king:   "K",
    ace:    "A"
  }.freeze

  def self.suits
    SUIT_STRINGS.keys
  end

  def self.royal_values
    VALUE_STRINGS.keys[-5..-1]
  end

  def self.values
    VALUE_STRINGS.keys
  end

  attr_reader :suit, :value

  def initialize(suit, value)
    unless Card.suits.include?(suit) && Card.values.include?(value)
      raise "illegal suit (#{suit.inspect}) or value (#{value.inspect})"
    end

    @suit, @value = suit, value
  end

  def to_s
    VALUE_STRINGS[value] + SUIT_STRINGS[suit]
  end

  def ==(other_card)
    (self.value == other_card.value) && (self.suit == other_card.suit)
  end

  def <=>(other_card)
    if self == other_card
      0
    elsif self.value != other_card.value
      Card.values.index(self.value) <=> Card.values.index(other_card.value)
    elsif self.suit != other_card.suit
      Card.suits.index(self.suit) <=> Card.suits.index(other_card.suit)
    end
  end
end
