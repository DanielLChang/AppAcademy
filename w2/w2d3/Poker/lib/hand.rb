require 'deck'

class Hand

  attr_accessor :hand

  def initialize(deck)
    @deck = deck
    @hand = populate_hand
  end

  def populate_hand
    result = []
    5.times do
      result << @deck.deal
    end
    result
  end

  def discard_card(card)
    @hand.delete(card)
  end

  def add_card(card)
    @hand << card
  end

  def compare_hands(other_hand)


  end

  def has_straight_flush
    #change this
    self.has_straight? && self.has_flush?
  end

  def has_straight
    values = []
    @hands.each do |card|
      values << card.value
    end
    values.sort!
    0.upto(values.length - 2) do |idx|
      diff = Card.values.index(value[idx]) - Card.values.index(value[idx + 1])
      return false unless diff == -1
    end
    true
  end

  def has_flush
    first_suit = @hands.first.suit
    @hands.all? { |card| card.suit == first_suit }
  end

  def has_4_pair

  end

  def has_3_pair
    values = []
    @hands.each do |card|
      values << card.value
    end
    values.sort!
    0.upto(values.length - 3) do |idx|
      return true if values[idx] == (values[idx + 1] && values[idx + 2])
    end
    false
  end

  def has_2_pair
    # @hands.each do |card|
    #   values << card.value
    # end
    # values.sort!
    # 0.upto(values.length - 2) do |idx|
    #   return [values[idx], ] if values[idx] == values[idx + 1]
    # end
    0.upto(@hand.length-2) do |idx|
      (idx + 1).upto(@hand.length - 2) do |idx2|
        if @hand[idx].value == @hand[idx2].value #comparing string values
          return Card.values.index(@hand[idx].value)
        end
      end
    end
    nil
  end

  def has_2_two_pairs
    first_highest_pair_val = -1
    second_highest_pair_value = -1
    0.upto(@hand.length-2) do |idx|
      (idx + 1).upto(@hand.length - 1) do |idx2|
        if @hand[idx].value == @hand[idx2].value #comparing string values
          curr_pair_val = Card.values.index(@hand[idx].value)
          if curr_pair_val > highest_pair_value
            first_highest_pair_value, second_highest_pair_value = Card.values.index(@hand[idx].value), first_highest_pair_value
          end
        end
      end
    end
    second_highest_pair_value != -1 ? highest_pair_value : nil
  end

end
