class Card

  attr_reader :value, :suit

  VALUES = %w(2 3 4 5 6 7 8 9 10 J Q K A).freeze
  SUITS = %w(d c h s).freeze

  def self.values
    VALUES
  end

  def self.suits
    SUITS
  end

  def initialize(value, suit)
    raise "Invalid value." unless VALUES.include?(value)
    raise "Invalid suit." unless SUITS.include?(suit)

    @value, @suit = value, suit
  end

  def compare(other_card)

    case VALUES.index(self.value) <=> VALUES.index(other_card.value)
    when 0
      case SUITS.index(self.suit) <=> SUITS.index(other_card.suit)
      when -1
        other_card
      when 1
        self
      end
    when 1
      self
    when -1
      other_card
    end
  end

end
